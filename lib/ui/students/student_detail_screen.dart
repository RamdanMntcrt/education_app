import 'dart:developer';

import 'package:edu_app/bloc/students_bloc/students_bloc.dart';
import 'package:edu_app/data/models/student_model.dart';
import 'package:edu_app/ui/custom%20widgets/custom_app_bar.dart';
import 'package:edu_app/utils/color_constants.dart';
import 'package:edu_app/utils/font_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/size_config.dart';

class StudentDetailScreen extends StatefulWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  StudentsBloc? studentsBloc;
  String? name, email, id, age;

  @override
  void initState() {
    // TODO: implement initState
    studentsBloc = StudentsBloc();
    log(widget.student.id!.toString());
    studentsBloc!.add(GetStudentDetailEvent(id: widget.student.id!));
    name = 'Name';
    email = 'email@email.com';
    id = 'nil';
    age = 'nil';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => studentsBloc!,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Student Detail',
          homeBar: false,
        ),
        body: SafeArea(
          child: BlocBuilder<StudentsBloc, StudentsState>(
            bloc: studentsBloc,
            buildWhen: (p, c) =>
                c != p && c is StudentDetailsLoadedState ||
                c is LoadingState ||
                c is LoadedState,
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 6,
                      width: SizeConfig.blockSizeHorizontal * 6,
                      child: const CircularProgressIndicator()),
                );
              }

              if (state is LoadedState) {
                return Container();
              }

              if (state is StudentDetailsLoadedState) {
                name = state.studentDetailModel.name!;
                email = state.studentDetailModel.email!;
                id = state.studentDetailModel.id!.toString();
                age = state.studentDetailModel.age!.toString();
              }
              return Column(
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  Center(
                    child: Container(
                      height: SizeConfig.blockSizeHorizontal * 30,
                      width: SizeConfig.blockSizeHorizontal * 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: ClrConst.primaryGrey),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.person,
                          color: ClrConst.whiteColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  Text(
                    name!,
                    style: const TextStyle(
                        fontFamily: Fonts.poppins,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  detailTile("Student ID:", id!),
                  detailTile("Age:", age!),
                  detailTile("email:", email!),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget detailTile(String title, String data) {
    return Column(
      children: [
        Text(
          "$title: $data",
          style: const TextStyle(
            fontFamily: Fonts.poppins,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeHorizontal * 3,
        ),
      ],
    );
  }
}
