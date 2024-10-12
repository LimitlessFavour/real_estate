import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/home.dart';
import 'package:real_estate/view/tab/home.dart';
import 'package:real_estate/view/tab/search.dart';
import 'package:real_estate/view/tab/favourites.dart';
import 'package:real_estate/view/tab/chat.dart';
import 'package:real_estate/view/tab/profile.dart';
import 'package:real_estate/widget/bottom_bar.dart';
import 'package:real_estate/widget/index_stack.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.watch<HomeModel>().currentTab;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppIndexedStack(
            index: selectedTab.index,
            children: const [
              Search(),
              Chat(),
              Home(),
              Favourites(),
              Profile(),
            ],
          ),
          const BottomBar(),
        ],
      ),
    );
  }
}
