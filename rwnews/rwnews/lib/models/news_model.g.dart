// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      source: json['source'] as String,
      date: DateTime.parse(json['date'] as String),
      content: json['content'] as String,
      image: json['image'] as String,
      email: json['email'] as String,
      createdAt: json['created_At'] == null
          ? null
          : DateTime.parse(json['created_At'] as String),
      updatedAt: json['updated_At'] == null
          ? null
          : DateTime.parse(json['updated_At'] as String),
      deleted: (json['deleted'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'date': instance.date.toIso8601String(),
      'content': instance.content,
      'image': instance.image,
      'email': instance.email,
      'created_At': instance.createdAt?.toIso8601String(),
      'updated_At': instance.updatedAt?.toIso8601String(),
      'deleted': instance.deleted,
    };
