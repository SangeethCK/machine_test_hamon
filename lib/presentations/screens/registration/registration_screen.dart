import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/class_room/class_room_bloc.dart';
import 'package:machine_test/applications/registration/registration_bloc.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/models/registration/registration_response.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/screens/registration/widgets/new_register.dart';
import 'package:machine_test/presentations/screens/registration/widgets/registerDetail.dart';
import 'package:machine_test/presentations/screens/students/student_screen.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RegistrationBloc>().add(const RegistrationLoaded());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          if (state.isStatus == ApiFetchStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          {
            return MainPadding(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headTitle(StringConstant.registration),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.registrationList?.length,
                        itemBuilder: (context, index) {
                          final data = state.registrationList?[index];
                          log(data?.student.toString() ?? '');
                          return RegistrationListCard(data: data);
                        }),
                  ),
                  commonButton(
                      onTap: () async {
                        final result = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const NewRegisterScreen();
                        }));
                        if (result == true) {
                          context
                              .read<RegistrationBloc>()
                              .add(const RegistrationLoaded());
                        }
                        context
                            .read<ClassRoomBloc>()
                            .add(ClearClassRoomStateEvent());
                      },
                      title: StringConstant.newRegistration),
                  40.verticalSpace,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class RegistrationListCard extends StatelessWidget {
  const RegistrationListCard({
    super.key,
    required this.data,
  });

  final Registration? data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<RegistrationBloc>()
            .add(RegistrationDetailEvent(id: data?.id));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const RegisterDetailScreen();
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 66.sp,
        width: 358.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kFillDark1Color,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Registration Id : #${data?.id}",
                    style: FontPalette.labelText1.copyWith(color: kBlack),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget commonButton(
    {required String title,
    Color? backgroudColor,
    Color? textColor,
    required Function onTap}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      height: 48.sp,
      width: 177.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroudColor ?? const Color.fromRGBO(0, 122, 255, 0.15)),
      child: Center(
          child: Text(
        title,
        style: FontPalette.head5.copyWith(color: textColor ?? kBlueColor),
      )),
    ),
  );
}
