import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../services/api_service.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  List<File> selectedFiles = [];
  String script = '';
  String resolution = '720p';
  String format = 'MP4';

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        selectedFiles = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  void startRender() async {
    if (selectedFiles.isEmpty || script.isEmpty) return;
    try {
      await ApiService().uploadFiles(selectedFiles, script);
      String jobId = await ApiService().startRender(script, selectedFiles.map((f) => f.path).toList());
      // Navigate to preview or status screen
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Créer montage')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(onPressed: pickFiles, child: Text('Sélectionner fichiers')),
            Text('Fichiers sélectionnés: ${selectedFiles.length}'),
            TextField(
              onChanged: (value) => script = value,
              decoration: InputDecoration(labelText: 'Script de montage'),
              maxLines: 5,
            ),
            DropdownButton<String>(
              value: resolution,
              items: ['720p', '1080p', '4K'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) => setState(() => resolution = value!),
            ),
            ElevatedButton(onPressed: startRender, child: Text('Monter vidéo')),
          ],
        ),
      ),
    );
  }
}