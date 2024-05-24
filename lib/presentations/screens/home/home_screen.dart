import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine_test/applications/home/bloc/home_bloc.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/helper.dart';
import 'package:machine_test/domain/core/constant/images.dart';
import 'package:machine_test/domain/routes/routes.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppbarWidget(
          title: 'Name',
          actions: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    context.read<HomeBloc>().add(ToggleViewEvent());
                  },
                  child: state is GridViewState == false
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 16),
                          child: SvgPicture.asset(Assets.actionIcon1),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 10, right: 16),
                          child: SvgPicture.asset(Assets.actionIcon2),
                        ),
                );
              },
            )
          ],
        ),
        body: MainPadding(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state is GridViewState == false
                      ? GridView.builder(
                          itemCount: homeList.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 28),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Navigator.pushNamed(context, student);
                                    break;
                                  case 1:
                                    Navigator.pushNamed(context, subjects);
                                    break;
                                  case 2:
                                    Navigator.pushNamed(context, classRoom);
                                    break;
                                  case 3:
                                    Navigator.pushNamed(context, registration);
                                  default:
                                }
                              },
                              child: Container(
                                height: 216,
                                width: 175,
                                decoration: BoxDecoration(
                                    color: index == 0
                                        ? kFillLight1Color
                                        : index == 1
                                            ? kFillLight2Color
                                            : index == 2
                                                ? kFillLight3Color
                                                : kFillLight4Color,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(homeList[index].icon),
                                    10.verticalSpace,
                                    Text(
                                      homeList[index].name,
                                      style: FontPalette.typoGraphy,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Navigator.pushNamed(context, student);
                                    break;
                                  case 1:
                                    Navigator.pushNamed(context, subjects);
                                    break;
                                  case 2:
                                    Navigator.pushNamed(context, classRoom);
                                    break;
                                  case 3:
                                    Navigator.pushNamed(context, registration);
                                  default:
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                margin: const EdgeInsets.only(
                                    right: 10, left: 10, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: index == 0
                                      ? kFillLight1Color
                                      : index == 1
                                          ? kFillLight2Color
                                          : index == 2
                                              ? kFillLight3Color
                                              : kFillLight4Color,
                                ),
                                width: 358.sp,
                                height: 48.sp,
                                child: Center(
                                  child: Text(
                                    homeList[index].name,
                                    textAlign: TextAlign.center,
                                    style: FontPalette.typoGraphy,
                                  ),
                                ),
                              ),
                            );
                          })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
