// To parse this JSON data, do
//
//     final subjectListModel = subjectListModelFromJson(jsonString);

import 'dart:convert';

SubjectListModel subjectListModelFromJson(String str) =>
    SubjectListModel.fromJson(json.decode(str));

String subjectListModelToJson(SubjectListModel data) =>
    json.encode(data.toJson());

class SubjectListModel {
  final List<Subject>? subjects;

  SubjectListModel({
    this.subjects,
  });

  factory SubjectListModel.fromJson(Map<String, dynamic> json) =>
      SubjectListModel(
        subjects: json["subjects"] == null
            ? []
            : List<Subject>.from(
                json["subjects"]!.map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subjects": subjects == null
            ? []
            : List<dynamic>.from(subjects!.map((x) => x.toJson())),
      };
}

class Subject {
  final int? credits;
  final int? id;
  final String? name;
  final String? teacher;

  Subject({
    this.credits,
    this.id,
    this.name,
    this.teacher,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
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
