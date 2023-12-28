import 'package:edu_app/data/models/classroom_model.dart';
import 'package:edu_app/data/models/classroom_model.dart';
import 'package:edu_app/ui/custom%20widgets/custom_app_bar.dart';
import 'package:edu_app/utils/color_constants.dart';
import 'package:edu_app/utils/font_constants.dart';
import 'package:edu_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/classroom_bloc/classroom_bloc.dart';

class ClassroomDetailScreen extends StatefulWidget {
  final Classroom classroom;

  const ClassroomDetailScreen({super.key, required this.classroom});

  @override
  State<ClassroomDetailScreen> createState() => _ClassroomDetailScreenState();
}

class _ClassroomDetailScreenState extends State<ClassroomDetailScreen> {
  ClassroomBloc? classroomBloc;

  @override
  void initState() {
    classroomBloc = ClassroomBloc();
    classroomBloc!.add(GetClassDetailEvent(id: widget.classroom.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => classroomBloc!,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Classroom Detail",
          homeBar: false,
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 3),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  const Text(
                    'This way up',
                    style: TextStyle(
                        color: ClrConst.primaryGrey,
                        fontSize: 18,
                        fontFamily: Fonts.poppins),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  Container(
                    height: SizeConfig.blockSizeHorizontal * 15,
                    width: SizeConfig.blockSizeHorizontal * 15,
                    decoration: BoxDecoration(
                        color: ClrConst.primaryDeepBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                        child: Text(
                      'T',
                      style: TextStyle(fontFamily: Fonts.poppins, fontSize: 24),
                    )),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  Expanded(
                      child: BlocBuilder<ClassroomBloc, ClassroomState>(
                    buildWhen: (p, c) =>
                        c != p && c is ClassroomDetailLoadedState ||
                        c is ClassroomLoadedState ||
                        c is ClassroomLoadingState,
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

                      if (state is ClassroomDetailLoadedState) {
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1,
                              // Set the number of columns as needed
                              crossAxisSpacing:
                                  SizeConfig.blockSizeHorizontal * 4,
                              mainAxisSpacing:
                                  SizeConfig.blockSizeHorizontal * 4,
                            ),
                            itemCount: state.classroomDetailModel.size,
                            itemBuilder: (BuildContext context, int index) {
                              return studentTile("${index + 1}".toString());
                            });
                      }
                      return Container();
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget studentTile(String index) {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 15,
      width: SizeConfig.blockSizeHorizontal * 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ClrConst.primaryDeepBlue.withOpacity(0.2)),
      child: Center(
          child: Text(
        "S$index",
        style: TextStyle(fontFamily: Fonts.poppins, fontSize: 24),
      )),
    );
  }
}
