import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster.dart';
import 'package:frontend/screens/component/menu.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/main/component/exp_bar.dart';
import 'package:frontend/screens/main/dialog/weekly_quest_dialog.dart';
import 'package:frontend/screens/main/partner/partner.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainProvider mainProvider;

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
  }

  void selectedMenu(String selected) {
    mainProvider.menuSelected(selected);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            TopBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const WeeklyQuestDialog();
                      },
                    );
                  },
                  child: Menu(
                    color: AppColors.basicpink,
                    shadowColor: AppColors.basicShadowPink,
                    icon: Icon(
                      FontAwesomeIcons.calendarCheck,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                    content: '주간 퀘스트',
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.04,
                // ),
                GestureDetector(
                  onTap: () {
                    context.go('/ranking');
                    selectedMenu('ranking');
                  },
                  child: Menu(
                    color: AppColors.basicgray,
                    shadowColor: AppColors.basicShadowGray,
                    icon: Icon(
                      FontAwesomeIcons.trophy,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                    content: '랭킹',
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.04,
                // ),
                GestureDetector(
                  onTap: () {
                    context.go('/history');
                    selectedMenu('history');
                  },
                  child: Menu(
                    color: AppColors.basicgreen,
                    shadowColor: AppColors.basicShadowGreen,
                    icon: Icon(
                      FontAwesomeIcons.clipboardList,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                    content: '히스토리',
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.04,
                // ),
                GestureDetector(
                  onTap: () {
                    context.go('/campaign');
                    selectedMenu('campaign');
                  },
                  child: Menu(
                    color: AppColors.basicnavy,
                    shadowColor: AppColors.basicShadowNavy,
                    icon: Icon(
                      FontAwesomeIcons.users,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                    content: '캠페인',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Partner(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ExpBar(),
                GestureDetector(
                  onTap: () {
                    context.push('/ploggingReady');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: AppColors.readyButton,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 3, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.basicgray.withOpacity(0.5),
                            offset: Offset(0, 4),
                            blurRadius: 1,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.003,
                          left: MediaQuery.of(context).size.width * 0.015,
                          child: Container(
                            child: Icon(
                              Icons.directions_run_sharp,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '   준비하기',
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung80_white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ClearMonster(),
          ],
        ),
      ),
    );
  }
}