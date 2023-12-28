import 'package:edu_app/bloc/subject_bloc/subject_bloc.dart';
import 'package:edu_app/ui/subjects/subect_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/color_constants.dart';
import '../../utils/font_constants.dart';
import '../../utils/size_config.dart';
import '../custom widgets/custom_app_bar.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  SubjectBloc? subjectBloc;

  @override
  void initState() {
    // TODO: implement initState
    subjectBloc = SubjectBloc();
    subjectBloc!.add(LoadSubjectListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => subjectBloc!,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Subjects",
          homeBar: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: BlocBuilder<SubjectBloc, SubjectState>(
                bloc: subjectBloc,
                buildWhen: (p, c) =>
                    c != p && c is SubjectListLoadedState ||
                    c is SubjectLoadingState ||
                    c is SubjectLoadedState,
                builder: (context, state) {
                  if (state is SubjectLoadingState) {
                    return Center(
                      child: SizedBox(
                          height: SizeConfig.blockSizeHorizontal * 6,
                          width: SizeConfig.blockSizeHorizontal * 6,
                          child: const CircularProgressIndicator()),
                    );
                  }

                  if (state is SubjectLoadedState) {
                    return Container();
                  }

                  if (state is SubjectListLoadedState) {
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeHorizontal * 10),
                        shrinkWrap: true,
                        itemCount: state.subject.length,
                        itemBuilder: (context, index) {
                          return subjectTile(state.subject[index].name!,
                              state.subject[index].teacher!, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubjectDetailScreen(
                                          subject: state.subject[index],
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

  Widget subjectTile(String? name, String? gmail, Function() onPressed) {
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
                  const Icon(CupertinoIcons.book_fill),
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
