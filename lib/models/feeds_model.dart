
class FeedModel {
  String? title;
  String? description;
  String? feedType;
  String? url;
  String? id;

  FeedModel({this.url, this.description, this.id, this.feedType, this.title});

  factory FeedModel.fromMap(Map<String, dynamic>? json) => FeedModel(
        description: json?['feedDescription'],
        feedType: json?['feedType'],
        id: json?['id'],
        title: json?['feedTitle'],
        url: json?['feedUrl'],
      );

  Map<String, dynamic> toMap() {
    return {
      'feedTitle': title,
      'feedDescription': description,
      'feedType': feedType,
      'feedUrl': url,
      'id': id,
    };
  }
}
