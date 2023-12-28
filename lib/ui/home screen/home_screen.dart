import 'dart:ffi';

import 'package:edu_app/ui/classroom/class_room_screen.dart';
import 'package:edu_app/ui/custom%20widgets/custom_app_bar.dart';
import 'package:edu_app/ui/students/students_screen.dart';
import 'package:edu_app/ui/subjects/subject_screen.dart';
import 'package:edu_app/utils/color_constants.dart';
import 'package:edu_app/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../utils/font_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Class Manager',
        homeBar: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 4,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                crossAxisSpacing: SizeConfig.blockSizeHorizontal * 2,
                mainAxisSpacing: SizeConfig.blockSizeHorizontal * 2,
                children: [
                  containerTile(0.1, "Students", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudentsScreen()));
                  }),
                  containerTile(0.2, "Subjects", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SubjectScreen()));
                  }),
                  containerTile(0.3, "Classroom", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClassroomScreen()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget containerTile(double opacity, String title, Function() onPressed) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: (BoxDecoration(
            color: ClrConst.primaryDeepBlue.withOpacity(opacity),
            borderRadius: BorderRadius.circular(12))),
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontFamily: Fonts.poppins, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
