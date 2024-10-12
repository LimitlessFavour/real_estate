import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/app/icons.dart';
import 'package:real_estate/app/theme.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/widget/button.dart';
import 'package:real_estate/widget/map.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchModel>().animateEntrance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        AppMap(),
        TopLayer(),
        AnimatedActionButtons(),
        AnimatedVariantsButton(),
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
            const AnimatedSearchBar(),
            Gap(6.w),
            const AnimatedFilterButton(),
          ],
        ),
      ),
    );
  }
}

class AnimatedSearchBar extends StatelessWidget {
  const AnimatedSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<SearchModel>().animationProgress;
    final scale = 0.5 + (0.5 * progress);
    final opacity = progress.clamp(0.0, 1.0);

    return Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        child: const SearchBar(),
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

class AnimatedFilterButton extends StatelessWidget {
  const AnimatedFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<SearchModel>().animationProgress;
    final scale = 0.5 + (0.5 * progress);
    final opacity = progress.clamp(0.0, 1.0);

    return Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        child: const FilterButton(),
      ),
    );
  }
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

class AnimatedActionButtons extends StatelessWidget {
  const AnimatedActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<SearchModel>().animationProgress;
    final scale = 0.5 + (0.5 * progress);

    return Positioned(
      left: 24.w,
      bottom: 84.h,
      child: Transform.scale(
        scale: scale,
        child: Column(
          children: [
            ActionButton(
              color: AppTheme.grey,
              icon: CustomIcons.fatrowsSvg(
                width: 24,
                height: 24,
                color: Colors.white,
              ),
              onPressed: null,
            ),
            const Gap(4),
            const ActionButton(
              color: AppTheme.grey,
              icon: RotatedIcon(),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}

class RotatedIcon extends StatelessWidget {
  const RotatedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 4,
      child: CustomIcons.rightSvg(
        width: 24,
        height: 24,
        color: Colors.white,
      ),
    );
  }
}

class AnimatedVariantsButton extends StatelessWidget {
  const AnimatedVariantsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<SearchModel>().animationProgress;
    final scale = 0.5 + (0.5 * progress);

    return Positioned(
      right: 24.w,
      bottom: 84.h,
      child: Transform.scale(
        scale: scale,
        child: const VariantsButton(),
      ),
    );
  }
}
