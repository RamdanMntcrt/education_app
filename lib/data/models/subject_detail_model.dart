// To parse this JSON data, do
//
//     final subjectDetailModel = subjectDetailModelFromJson(jsonString);

import 'dart:convert';

SubjectDetailModel subjectDetailModelFromJson(String str) =>
    SubjectDetailModel.fromJson(json.decode(str));

String subjectDetailModelToJson(SubjectDetailModel data) =>
    json.encode(data.toJson());

class SubjectDetailModel {
  final int? credits;
  final int? id;
  final String? name;
  final String? teacher;

  SubjectDetailModel({
    this.credits,
    this.id,
    this.name,
    this.teacher,
  });

  factory SubjectDetailModel.fromJson(Map<String, dynamic> json) =>
      SubjectDetailModel(
        credits: json["credits"],
        id: json["id"],
        name: json["name"],
        teacher: json["teacher"],
      );

  Map<String, dynamic> toJson() => {
        "credits": credits,
        "id": id,
        "name": name,
        "teacher": teacher,
      };
}
