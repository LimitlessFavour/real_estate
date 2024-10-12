import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate/app/icons.dart';
import 'package:real_estate/app/theme.dart';
import 'package:real_estate/widget/button.dart';
import 'package:real_estate/widget/map.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        AppMap(),
        TopLayer(),
        ActionButtons(),
        VariantsButton(),
      ],
    );
  }
}

class TopLayer extends StatelessWidget {
  const TopLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 48.w,
      left: 0.w,
      right: 0.w,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SearchBar(),
            Gap(6.w),
            const FilterButton(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: 'Saint Petersburg');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 0.6.sw,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            splashColor: Colors.transparent,
            icon: CustomIcons.searchSvg(
              width: 24,
              height: 24,
              color: Colors.black.withOpacity(0.8),
            ),
            onPressed: () {
              searchController.clear();
              onSearchTextChanged('');
            },
          ),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: '  Search',
                hintStyle: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.secondary,
                ),
                border: InputBorder.none,
                fillColor: theme.colorScheme.surface,
              ),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.tertiary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              onChanged: onSearchTextChanged,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onSearchTextChanged(String text) async {}
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ActionButton(
      color: Colors.white,
      icon: CustomIcons.candleSvg(
        width: 18,
        height: 18,
        color: theme.colorScheme.tertiary,
      ),
      onPressed: () {},
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24.w,
      bottom: 84.h,
      child: Column(
        children: [
          ActionButton(
            color: AppTheme.grey,
            icon: CustomIcons.fatrowsSvg(
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          Gap(4.h),
          ActionButton(
            color: AppTheme.grey,
            icon: Transform.rotate(
              angle: -pi / 4,
              child: CustomIcons.rightSvg(
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              print('dhfgg');
            },
          ),
        ],
      ),
    );
  }
}
