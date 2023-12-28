import 'package:edu_app/bloc/classroom_bloc/classroom_bloc.dart';
import 'package:edu_app/ui/classroom/classroom_detail_screen.dart';
import 'package:edu_app/ui/custom%20widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/color_constants.dart';
import '../../utils/font_constants.dart';
import '../../utils/size_config.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({super.key});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  ClassroomBloc? classroomBloc;

  @override
  void initState() {
    classroomBloc = ClassroomBloc();
    classroomBloc!.add(GetClassroomListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => classroomBloc!,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Classroom',
          homeBar: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: BlocBuilder<ClassroomBloc, ClassroomState>(
                buildWhen: (p, c) =>
                    c != p && c is ClassroomListLoadedState ||
                    c is ClassroomLoadingState ||
                    c is ClassroomLoadedState,
                bloc: classroomBloc,
                builder: (context, state) {
                  if (state is ClassroomLoadingState) {
                    return Center(
                      child: SizedBox(
                          height: SizeConfig.blockSizeHorizontal * 6,
                          width: SizeConfig.blockSizeHorizontal * 6,
                          child: const CircularProgressIndicator()),
                    );
                  }

                  if (state is ClassroomLoadedState) {
                    return Container();
                  }

                  if (state is ClassroomListLoadedState) {
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeHorizontal * 10),
                        shrinkWrap: true,
                        itemCount: state.classroom.length,
                        itemBuilder: (context, index) {
                          return studentTile(state.classroom[index].name!,
                              state.classroom[index].size!.toString(), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClassroomDetailScreen(
                                          classroom: state.classroom[index],
                                        )));
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

  Widget studentTile(String? name, String? size, Function() onPressed) {
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
                  const Icon(CupertinoIcons.person_3_fill),
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
                        "$size students",
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
