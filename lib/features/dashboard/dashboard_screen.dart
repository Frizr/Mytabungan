import 'package:tabungan_frontend/features/dashboard/models/tab_icon_data.dart';

import 'package:flutter/material.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'app_theme.dart';
import 'home/home_screen.dart';
import 'home/add_transaction_dialog.dart';
import 'history/history_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = HomeScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            tabBody,
            bottomBar(),
          ],
        ),
      ),
    );
  }



  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            showDialog(
              context: context,
              builder: (context) => AddTransactionDialog(),
            );
          },
          changeIndex: (int index) {
            animationController?.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                if (index == 0) {
                  tabBody =
                      HomeScreen(animationController: animationController);
                } else if (index == 1) {
                  tabBody =
                      HistoryScreen(animationController: animationController);
                }
              });
            });
          },
        ),
      ],
    );
  }
}
