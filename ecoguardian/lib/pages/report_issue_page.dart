import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:typed_data';
import 'dart:convert'; // Import for Base64 encoding/decoding
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({super.key});

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  Uint8List? _imageBytes;
  final picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();
  LatLng? _selectedPosition;
  GoogleMapController? _mapController;
  final Location _location = Location();
  final Set<Marker> _markers = {};

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _takePhoto() async {
    if (kIsWeb) {
      final html.VideoElement video = html.VideoElement();
      final html.CanvasElement canvas =
          html.CanvasElement(width: 640, height: 480);

      html.MediaStream? stream;

      // Ask for permission and access the camera
      try {
        stream = await html.window.navigator.mediaDevices!
            .getUserMedia({'video': true});
        video.srcObject = stream;
        video.autoplay = true;
        video.style.display = 'none';
        html.document.body!.append(video);

        video.onLoadedData.listen((_) {
          final context =
              canvas.getContext('2d') as html.CanvasRenderingContext2D;
          context.drawImageScaled(video, 0, 0, canvas.width!, canvas.height!);

          final dataUrl = canvas.toDataUrl('image/png');
          final base64String = dataUrl.split(',').last;
          final bytes = base64.decode(base64String);

          setState(() {
            _imageBytes = Uint8List.fromList(bytes);
          });

          // Clean up
          stream!.getTracks().forEach((track) => track.stop());
          video.remove();
        });
      } catch (e) {
        print('Error accessing camera: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error accessing camera: $e')),
        );
      }
    } else {
      // Mobile-specific camera handling
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
        });
      } else {
        print('No photo taken.');
      }
    }
  }

  Future<void> _uploadImage() async {
    if (_imageBytes == null) return;

    try {
      String fileName =
          'report_images/${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      UploadTask uploadTask = storageReference.putData(_imageBytes!);

      TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      _saveReport(downloadUrl);
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  Future<void> _saveReport(String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection('reports').add({
        'description': _descriptionController.text,
        'image_url': imageUrl,
        'location':
            GeoPoint(_selectedPosition!.latitude, _selectedPosition!.longitude),
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Report saved successfully.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report submitted successfully')),
      );
    } catch (e) {
      print('Error saving report: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving report: $e')),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedPosition = position;
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: const InfoWindow(
          title: 'Selected Location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issue'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 300.0,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    onTap: _onMapTapped,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(0, 0),
                      zoom: 2,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: _markers,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Upload Photo'),
                  ),
                  ElevatedButton(
                    onPressed: _takePhoto,
                    child: const Text('Take Photo'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _imageBytes == null
                  ? const Text('No image selected.')
                  : Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.memory(
                          _imageBytes!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Provide Description of the Activity',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _uploadImage,
                child: const Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
