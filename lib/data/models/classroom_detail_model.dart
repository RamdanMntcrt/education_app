// To parse this JSON data, do
//
//     final classroomDetailModel = classroomDetailModelFromJson(jsonString);

import 'dart:convert';

ClassroomDetailModel classroomDetailModelFromJson(String str) =>
    ClassroomDetailModel.fromJson(json.decode(str));

String classroomDetailModelToJson(ClassroomDetailModel data) =>
    json.encode(data.toJson());

class ClassroomDetailModel {
  final int? id;
  final String? layout;
  final String? name;
  final int? size;
  final String? subject;

  ClassroomDetailModel({
    this.id,
    this.layout,
    this.name,
    this.size,
    this.subject,
  });

  factory ClassroomDetailModel.fromJson(Map<String, dynamic> json) =>
      ClassroomDetailModel(
        id: json["id"],
        layout: json["layout"],
        name: json["name"],
        size: json["size"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "layout": layout,
        "name": name,
        "size": size,
        "subject": subject,
      };
}
