import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/class_room/class_room_bloc.dart';
import 'package:machine_test/applications/registration/registration_bloc.dart';
import 'package:machine_test/domain/core/constant/helper.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/routes/routes.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';

import 'package:machine_test/presentations/screens/registration/widgets/register_card_widget.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/button/common_buttons.dart';
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
                    child: (state.registrationList?.isEmpty ?? true)
                        ? Center(
                            child: Text(
                              StringConstant.noFound,
                              style: FontPalette.labelText1,
                            ),
                          )
                        : ListView.builder(
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
                        context
                            .read<ClassRoomBloc>()
                            .add(ClearClassRoomStateEvent());

                        Navigator.pushNamed(context, newRegister);
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
