import 'dart:developer';

import 'package:edu_app/bloc/students_bloc/students_bloc.dart';
import 'package:edu_app/ui/custom%20widgets/custom_app_bar.dart';
import 'package:edu_app/ui/students/student_detail_screen.dart';
import 'package:edu_app/utils/font_constants.dart';
import 'package:edu_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/color_constants.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  StudentsBloc? studentsBloc;

  @override
  void initState() {
    // TODO: implement initState
    studentsBloc = StudentsBloc();

    studentsBloc!.add(GetStudentsListEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => studentsBloc!,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Students",
          homeBar: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              //we can't implement pagination because the api is not made for that

              Expanded(
                  child: BlocBuilder<StudentsBloc, StudentsState>(
                bloc: studentsBloc,
                buildWhen: (p, c) =>
                    c != p && c is StudentListLoadedState ||
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

                  if (state is StudentListLoadedState) {
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeHorizontal * 10),
                        shrinkWrap: true,
                        itemCount: state.student.length,
                        itemBuilder: (context, index) {
                          return studentTile(state.student[index].name!,
                              state.student[index].email!, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentDetailScreen(
                                        student: state.student[index])));
                          });
                        });
                  }
                  return Container();
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget studentTile(String? name, String? gmail, Function() onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeHorizontal * 2,
          horizontal: SizeConfig.blockSizeHorizontal * 3),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
            decoration: BoxDecoration(
                color: ClrConst.primaryDeepBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeHorizontal * 4,
                  horizontal: SizeConfig.blockSizeHorizontal * 2),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.person_alt),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name!,
                        style: const TextStyle(
                            fontFamily: Fonts.poppins,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal * 1.5,
                      ),
                      Text(
                        gmail!,
                        style: const TextStyle(
                          fontFamily: Fonts.poppins,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
