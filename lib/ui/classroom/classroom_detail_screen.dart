import 'dart:developer';

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
  int? topLayer, bottomLayer;
  double? tableHeight;

  @override
  void initState() {
    classroomBloc = ClassroomBloc();
    classroomBloc!.add(GetClassDetailEvent(id: widget.classroom.id!));
    topLayer = 0;
    bottomLayer = 0;
    tableHeight = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => classroomBloc!,
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.classroom.name!,
          homeBar: false,
          actionIcon: optionsTile(),
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
                    'Faces this way',
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
                    child: Center(
                        child: Transform.rotate(
                      angle: 1.6,
                      child: const Text(
                        'T',
                        style:
                            TextStyle(fontFamily: Fonts.poppins, fontSize: 24),
                      ),
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
                        if (state.classroomDetailModel.layout == 'classroom') {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1,
                                // Set the number of columns as needed
                                crossAxisSpacing:
                                    SizeConfig.blockSizeHorizontal * 2,
                                mainAxisSpacing:
                                    SizeConfig.blockSizeHorizontal * 2,
                              ),
                              itemCount: state.classroomDetailModel.size,
                              itemBuilder: (BuildContext context, int index) {
                                return studentTile("${index + 1}");
                              });
                        } else if (state.classroomDetailModel.layout ==
                            'conference') {
                          bottomLayer = state.classroomDetailModel.size! ~/ 2;

                          topLayer =
                              state.classroomDetailModel.size! - bottomLayer!;
                          tableHeight = SizeConfig.blockSizeHorizontal *
                              17 *
                              (topLayer! > bottomLayer!
                                  ? topLayer!
                                  : bottomLayer!);

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        for (int i = 0; i < bottomLayer!; i++)
                                          studentTile("${i + 1 + topLayer!}"),
                                      ],
                                    ),
                                    Container(
                                      height: tableHeight,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 40,
                                      decoration: BoxDecoration(
                                          color: ClrConst.primaryDeepBlue
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: const Center(),
                                    ),
                                    Column(
                                      children: [
                                        for (int i = 0; i < topLayer!; i++)
                                          studentTile("${i + 1}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
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

  Widget studentTile(String number) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ClrConst.primaryDeepBlue.withOpacity(0.2)),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
          child: Center(
              child: Transform.rotate(
            angle: 1.58,
            child: Text(
              "S$number",
              style: const TextStyle(fontFamily: Fonts.poppins, fontSize: 24),
            ),
          )),
        ),
      ),
    );
  }

  Widget optionsTile() {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          const PopupMenuItem(value: 0, child: Text('Change/Add subject'))
        ];
      },
      onSelected: (val) {
        if (val == 0) {
          log('Change/Add subject');
        }
      },
    );
  }
}
