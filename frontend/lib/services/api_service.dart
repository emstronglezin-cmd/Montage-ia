import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  Future<String> uploadFiles(List<File> files, String script) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));
    for (var file in files) {
      request.files.add(await http.MultipartFile.fromPath('files', file.path));
    }
    request.fields['script'] = script;
    var response = await request.send();
    if (response.statusCode == 200) {
      return 'Uploaded';
    } else {
      throw Exception('Failed to upload');
    }
  }

  Future<String> startRender(String script, List<String> fileIds) async {
    final response = await http.post(
      Uri.parse('$baseUrl/render'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'script': script, 'files': fileIds}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['jobId'];
    } else {
      throw Exception('Failed to start render');
    }
  }

  Future<String> getStatus(String jobId) async {
    final response = await http.get(Uri.parse('$baseUrl/status/$jobId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('Failed to get status');
    }
  }

  Future<String> downloadVideo(String videoId) async {
    return '$baseUrl/download/$videoId';
  }

  Future<Map<String, dynamic>> getQuota() async {
    final response = await http.get(Uri.parse('$baseUrl/user/quota'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get quota');
    }
  }
}