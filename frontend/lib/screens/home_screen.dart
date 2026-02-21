import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/video.dart';
import '../services/api_service.dart';
import 'create_screen.dart';
import 'videos_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Montage IA')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CreateScreen())),
              child: Text('Nouveau montage'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideosScreen())),
              child: Text('Mes vidéos'),
            ),
            Consumer<ApiService>(
              builder: (context, api, child) {
                return FutureBuilder(
                  future: api.getQuota(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text('Crédits restants: ${snapshot.data!['remaining']}');
                    }
                    return Text('Chargement...');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}