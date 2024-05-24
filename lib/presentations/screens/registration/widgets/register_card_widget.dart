import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/registration/registration_bloc.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/models/registration/registration_response.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/screens/registration/register_detail_screen.dart';

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
        context.read<RegistrationBloc>().add(ClearRegStateEvent());
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
