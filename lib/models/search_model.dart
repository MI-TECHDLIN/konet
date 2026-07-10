class SearchModel {
  final String email;
  final String id;

  SearchModel({required this.id, required this.email});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(id: json['id'], email: json['']);
  }
}
