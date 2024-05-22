import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/demo.dart';
import 'package:machine_test/domain/routes/routes.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool islog = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: 'Hello,\n',
                style: FontPalette.head1,
                children: [
              TextSpan(text: 'Good Moring', style: FontPalette.headSub2)
            ])),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                islog = !islog;
              });
            },
            child: islog == false
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 16),
                    child:
                        SvgPicture.asset('assets/images/eva_menu-outline.svg'),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 10, right: 16),
                    child: SvgPicture.asset('assets/images/bi_grid-1x2.svg'),
                  ),
          )
        ],
      ),
      body: MainPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            islog == false
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
                          Navigator.pushNamed(context, classRoomDetail);
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
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
                      return Container(
                        padding: const EdgeInsets.only(right: 10, left: 10),
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
                      );
                    })
          ],
        ),
      ),
    );
  }
}
