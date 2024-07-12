import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:io';

class ReportIssuePage extends StatefulWidget {
  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _descriptionController = TextEditingController();
  LatLng? _currentPosition;
  GoogleMapController? _mapController;
  Location _location = Location();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      String fileName =
          'report_images/${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      UploadTask uploadTask = storageReference.putFile(_image!);
      TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();
      _saveReport(downloadUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _saveReport(String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection('reports').add({
        'description': _descriptionController.text,
        'image_url': imageUrl,
        'location':
            GeoPoint(_currentPosition!.latitude, _currentPosition!.longitude),
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Report saved successfully.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Report submitted successfully')),
      );
    } catch (e) {
      print('Error saving report: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _location.onLocationChanged.listen((l) {
      setState(() {
        _currentPosition = LatLng(l.latitude!, l.longitude!);
      });
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  Future<void> _getCurrentLocation() async {
    var location = await _location.getLocation();
    setState(() {
      _currentPosition = LatLng(location.latitude!, location.longitude!);
    });
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition!, zoom: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Issue'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? Text('No image selected.') : Image.file(_image!),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
            SizedBox(
              height: 300.0,
              child: _currentPosition == null
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _currentPosition!,
                        zoom: 15,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}
