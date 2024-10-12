import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/app/icons.dart';
import 'package:real_estate/models/home.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedTab = context.watch<HomeModel>().currentTab;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: 20.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
          color: selected ? theme.colorScheme.primary : const Color(0xff232220),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getCustomIcon(value, selected ? 28 : 24),
          ],
        ),
      ),
    );
  }
}

Widget _getCustomIcon(HomeTab tab, double size) {
  switch (tab) {
    case HomeTab.home:
      return CustomIcons.homeSvg(
          width: size, height: size, color: Colors.white);
    case HomeTab.search:
      return CustomIcons.searchSvg(
          width: size, height: size, color: Colors.white);
    case HomeTab.chat:
      return CustomIcons.messageSvg(
          width: size, height: size, color: Colors.white);
    case HomeTab.favourites:
      return CustomIcons.heartSvg(
          width: size, height: size, color: Colors.white);
    case HomeTab.profile:
      return CustomIcons.profileSvg(
          width: size, height: size, color: Colors.white);
  }
}

double _getBottomBarHeight(ThemeData theme) {
  return 60.0;
}
