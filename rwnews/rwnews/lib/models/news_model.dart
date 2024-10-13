import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class News {
  final int id;
  final String title;
  final String source;
  final DateTime date;
  final String content;
  final String image;
  final String email;
  @JsonKey(name: 'created_At')
  DateTime? createdAt;
  @JsonKey(name: 'updated_At')
  DateTime? updatedAt;
  int? deleted;

  News({
    required this.id,
    required this.title,
    required this.source,
    required this.date,
    required this.content,
    required this.image,
    required this.email,
    this.createdAt,
    this.updatedAt,
    this.deleted,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}