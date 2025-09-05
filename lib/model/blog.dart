import 'dart:convert';

List<BlogModel> blogModelListFromJson(String str) =>
    List<BlogModel>.from(json.decode(str).map((x) => BlogModel.fromJson(x)));

String blogModelListToJson(List<BlogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogModel {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? content;
  final List<String>? images;
  final String? authorName;
  final String? authorImage;
  final DateTime? publishDate;
  final int? likes;
  final int? comments;
  final List<String>? tags;
  final int? readTime;

  BlogModel({
    this.id,
    this.title,
    this.subtitle,
    this.content,
    this.images,
    this.authorName,
    this.authorImage,
    this.publishDate,
    this.likes,
    this.comments,
    this.tags,
    this.readTime,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    id: json["id"] ?? "",
    title: json["title"] ?? "",
    subtitle: json["subtitle"] ?? "",
    content: json["content"] ?? "",
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"].map((x) => x ?? "")),
    authorName: json["authorName"] ?? "",
    authorImage: json["authorImage"] ?? "",
    publishDate: json["publishDate"] != null
        ? DateTime.tryParse(json["publishDate"]) ?? DateTime.now()
        : DateTime.now(),
    likes: json["likes"] ?? 0,
    comments: json["comments"] ?? 0,
    tags: json["tags"] == null
        ? []
        : List<String>.from(json["tags"].map((x) => x ?? "")),
    readTime: json["readTime"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "content": content,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "authorName": authorName,
    "authorImage": authorImage,
    "publishDate": publishDate!.toIso8601String(),
    "likes": likes,
    "comments": comments,
    "tags": List<dynamic>.from(tags!.map((x) => x)),
    "readTime": readTime,
  };
}
