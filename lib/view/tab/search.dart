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
    final progress = context.watch<SearchModel>().widgetAnimationProgress;
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
    final progress = context.watch<SearchModel>().widgetAnimationProgress;
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
    final progress = context.watch<SearchModel>().widgetAnimationProgress;
    final scale = 0.5 + (0.5 * progress);

    return Positioned(
      left: 24.w,
      bottom: 84.h,
      child: Transform.scale(
        scale: scale,
        child: Column(
          children: [
            const ToogleState(),
            const Gap(4),
            ActionButton(
              color: AppTheme.grey,
              icon: const RotatedIcon(),
              onPressed: () {},
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
    final progress = context.watch<SearchModel>().widgetAnimationProgress;
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

class ToogleState extends StatelessWidget {
  const ToogleState({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
      builder: (context, searchModel, child) {
        return ActionButton(
          color: AppTheme.grey,
          icon: CustomIcons.fatrowsSvg(
            width: 24,
            height: 24,
            color: Colors.white,
          ),
          onPressed: () {
            searchModel.toggleFilterMenu();
            if (searchModel.isFilterMenuOpen) {
              _showFilterMenu(context);
            }
          },
        );
      },
    );
  }

  void _showFilterMenu(BuildContext context) {
    final searchModel = Provider.of<SearchModel>(context, listen: false);
    OverlayEntry? entry;

    entry = OverlayEntry(
      builder: (context) => FilterMenu(
        onDismiss: () {
          searchModel.closeFilterMenu();
          entry?.remove();
        },
      ),
    );

    Overlay.of(context).insert(entry);
  }
}

class FilterMenu extends StatefulWidget {
  final VoidCallback onDismiss;

  const FilterMenu({super.key, required this.onDismiss});

  @override
  State<FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isVisible = true;
      });
    });
  }

  void _dismiss() {
    setState(() {
      _isVisible = false;
    });
    Future.delayed(const Duration(milliseconds: 300), widget.onDismiss);
  }

  @override
  Widget build(BuildContext context) {
    final propertyFilter = Provider.of<PropertyFilter>(context);

    return Material(
      color: Colors.transparent,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _isVisible ? 1.0 : 0.0,
        child: GestureDetector(
          onTap: _dismiss,
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  left: 40.w,
                  bottom: 140.h,
                  child: GestureDetector(
                    onTap: () {}, // Prevent taps on the menu from dismissing it
                    child: Container(
                      width: 170.w,
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: const Color(0xffFBF5EB),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildMenuItem(
                            'Cosy areas',
                            CustomIcons.heartSvg,
                            isSelected: propertyFilter.showCozyOnly,
                            onPressed: () => propertyFilter
                                .setShowCozyOnly(!propertyFilter.showCozyOnly),
                          ),
                          _buildMenuItem(
                            'Price',
                            CustomIcons.buildingSvg,
                            isSelected: propertyFilter.markerDisplay ==
                                PropertyMarkerDisplay.price,
                            onPressed: () => propertyFilter
                                .setMarkerDisplay(PropertyMarkerDisplay.price),
                          ),
                          _buildMenuItem(
                            'Infrastructure',
                            CustomIcons.candleSvg,
                            isSelected: propertyFilter.markerDisplay ==
                                PropertyMarkerDisplay.infrastructure,
                            onPressed: () => propertyFilter.setMarkerDisplay(
                                PropertyMarkerDisplay.infrastructure),
                          ),
                          _buildMenuItem(
                            'Without any layer',
                            CustomIcons.homeSvg,
                            isSelected: propertyFilter.markerDisplay ==
                                PropertyMarkerDisplay.none,
                            onPressed: () => propertyFilter
                                .setMarkerDisplay(PropertyMarkerDisplay.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String text,
    Widget Function({double? width, double? height, Color? color})
        iconBuilder, {
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                key: ValueKey<bool>(isSelected),
                width: 20.w,
                height: 20.w,
                child: iconBuilder(
                  color: isSelected ? AppTheme.primaryColor : Colors.black,
                ),
              ),
            ),
            Gap(12.w),
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: theme.textTheme.labelLarge!.copyWith(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : theme.colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
