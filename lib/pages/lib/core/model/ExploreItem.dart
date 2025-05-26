// ignore_for_file: file_names

class ExploreItem {
  final String imageUrl;

  ExploreItem({required this.imageUrl});

  factory ExploreItem.fromJson(Map<String, dynamic> json) {
    return ExploreItem(imageUrl: json['image_url']);
  }
}
