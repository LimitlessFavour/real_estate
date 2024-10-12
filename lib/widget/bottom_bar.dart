import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estate/models/home.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedTab = context.watch<HomeModel>().currentTab;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: 50.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xff2b2b2b),
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: HomeTab.values.asMap().entries.map((entry) {
              final int index = entry.key;
              final HomeTab tab = entry.value;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Button(
                    groupValue: selectedTab,
                    value: tab,
                  ),
                  if (index < HomeTab.values.length - 1) Gap(10.w),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
    required this.groupValue,
    required this.value,
  });

  final HomeTab groupValue;
  final HomeTab value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = groupValue == value;
    final color = selected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface.withOpacity(0.6);

    return GestureDetector(
      onTap: () => context.read<HomeModel>().setHomeTab(value),
      child: AnimatedContainer(
        height: _getBottomBarHeight(theme),
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(selected ? 12.w : 8.w),
        decoration: BoxDecoration(
          color:
              selected ? theme.colorScheme.tertiary : const Color(0xff232220),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              _getIconData(value),
              size: selected ? 28 : 24,
              color: Colors.white,
            ),
            // AnimatedContainer(
            //   duration: const Duration(milliseconds: 300),
            //   curve: Curves.bounceOut,
            //   height: selected ? 4 : 0,
            //   width: selected ? 4 : 0,
            //   margin: const EdgeInsets.only(top: 4),
            //   decoration: BoxDecoration(
            //     color: theme.colorScheme.tertiary,
            //     shape: BoxShape.circle,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(HomeTab tab) {
    switch (tab) {
      case HomeTab.home:
        return FontAwesomeIcons.house;
      case HomeTab.search:
        return FontAwesomeIcons.magnifyingGlass;
      case HomeTab.chat:
        return FontAwesomeIcons.comments;
      case HomeTab.favourites:
        return FontAwesomeIcons.heart;
      case HomeTab.profile:
        return FontAwesomeIcons.user;
    }
  }
}

double _getBottomBarHeight(ThemeData theme) {
  return 60.0;
}
