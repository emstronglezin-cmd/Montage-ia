import 'package:flutter/material.dart';
import '../models/video.dart';

class VideosScreen extends StatelessWidget {
  final List<Video> videos = []; // Fetch from API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mes vidéos')),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(videos[index].title),
            subtitle: Text(videos[index].status),
          );
        },
      ),
    );
  }
}