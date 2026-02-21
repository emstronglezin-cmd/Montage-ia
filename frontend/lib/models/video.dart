class Video {
  final String id;
  final String title;
  final String url;
  final String status; // pending, processing, completed

  Video({required this.id, required this.title, required this.url, required this.status});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      status: json['status'],
    );
  }
}