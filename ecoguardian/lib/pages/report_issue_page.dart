import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class ReportIssuePage extends StatefulWidget {
  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  Uint8List? _imageBytes;
  final picker = ImagePicker();
  TextEditingController _descriptionController = TextEditingController();
  LatLng? _selectedPosition;
  GoogleMapController? _mapController;
  Location _location = Location();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        // For web, read as bytes
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
        });
      } else {
        // For mobile, read as file
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
        });
      }
    } else {
      print('No image selected.');
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
        SnackBar(content: Text('Report submitted successfully')),
      );
    } catch (e) {
      print('Error saving report: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedPosition = position;
    });
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
            _imageBytes == null
                ? Text('No image selected.')
                : kIsWeb
                    ? Image.memory(_imageBytes!)
                    : Image.memory(_imageBytes!),
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
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                onTap: _onMapTapped,
                initialCameraPosition: CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 2,
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
