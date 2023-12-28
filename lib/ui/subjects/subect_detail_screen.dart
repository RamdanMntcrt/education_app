import 'package:edu_app/bloc/subject_bloc/subject_bloc.dart';
import 'package:edu_app/data/models/student_model.dart';
import 'package:edu_app/data/models/subject_model.dart';
import 'package:edu_app/ui/custom%20widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/font_constants.dart';
import '../../utils/size_config.dart';

class SubjectDetailScreen extends StatefulWidget {
  final Subject subject;

  const SubjectDetailScreen({super.key, required this.subject});

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  SubjectBloc? subjectBloc;

  String? name, credit, faculty, subId;

  @override
  void initState() {
    subjectBloc = SubjectBloc();

    subjectBloc!.add(GetSubjectDetailsEvent(id: widget.subject.id!));
    name = 'Unknown';
    credit = 'nil';
    faculty = 'Unknown';
    subId = 'nil';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        homeBar: false,
        title: 'Subject Details',
      ),
      body: SafeArea(
        child: BlocBuilder<SubjectBloc, SubjectState>(
          bloc: subjectBloc,
          buildWhen: (p, c) =>
              c != p && c is SubjectDetailsLoadedState ||
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

            if (state is SubjectDetailsLoadedState) {
              name = state.subjectDetailModel.name!;
              faculty = state.subjectDetailModel.teacher;
              credit = state.subjectDetailModel.credits.toString();
              subId = state.subjectDetailModel.id.toString();
            }

            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  Text(
                    name!,
                    style: const TextStyle(
                        fontFamily: Fonts.poppins,
                        fontSize: 35,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  detailTile('Faculty', faculty!),
                  detailTile('Subject ID', subId!),
                  detailTile('Subject Credit', credit!),
                ],
              ),
            );
          },
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
