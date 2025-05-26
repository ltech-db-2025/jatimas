// ignore_for_file: file_names

class Review {
  String photoUrl;
  String name;
  String review;
  double rating;

  Review({required this.photoUrl, required this.name, required this.review, required this.rating});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(photoUrl: json['photo_url'], name: json['name'], review: json['review'], rating: json['rating']);
  }
}
