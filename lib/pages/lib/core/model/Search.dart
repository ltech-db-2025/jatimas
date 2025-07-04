// ignore_for_file: file_names

class SearchHistory {
  String title;

  SearchHistory({required this.title});

  factory SearchHistory.fromJson(Map<String, dynamic> json) {
    return SearchHistory(title: json['title']);
  }
}

class PopularSearch {
  String title;
  String imageUrl;

  PopularSearch({required this.title, required this.imageUrl});

  factory PopularSearch.fromJson(Map<String, dynamic> json) {
    return PopularSearch(title: json['title'], imageUrl: json['image_url']);
  }
}
