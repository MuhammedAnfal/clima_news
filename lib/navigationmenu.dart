import 'package:clima_news/common/widgets/shimmer/news_shimmer.dart';
import 'package:clima_news/features/news/screens/home/weather_screen.dart';
import 'package:clima_news/features/news/screens/news/news_screen.dart';
import 'package:clima_news/features/personalization/screens/profile/profile_screen.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:clima_news/features/utils/helper/helper_funtion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  //--variables
  final List<NavBarItemData> _navBarItems = [
    NavBarItemData(icon: Iconsax.cloud_drizzle, label: AppStrings.weatherText),
    NavBarItemData(icon: Icons.newspaper, label: AppStrings.newsText),
    NavBarItemData(icon: Icons.person_outline_rounded, label: AppStrings.profileText),
  ];

  // List of different pages to display based on selection
  final List<Widget> _pages = [const WeatherScreen(), NewsScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => CustomNavigationBar(
          selectedIndex: navigationController.selectedIndex.value,
          onItemSelected: (value) {
            navigationController.selectedIndex.value = value;
          },
          items: _navBarItems,
        ),
      ),
      body: Obx(() => _pages[navigationController.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
}

class NavBarItemData {
  final IconData icon;
  final String label;

  const NavBarItemData({required this.icon, required this.label});
}

/// Custom navigation bar widget with animated selection.
class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<NavBarItemData> items;

  const CustomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.screenHeight * 0.015,
        horizontal: context.screenWidth * 0.03,
      ),
      height: context.screenHeight * 0.1, // Fixed height for the navigation bar
      decoration: BoxDecoration(
        color: AppColors.lightBackground, // Light blue background for the bar
        borderRadius: BorderRadius.circular(40), // Fully rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribute items evenly
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == selectedIndex;

          return _NavBarItem(
            icon: item.icon,
            label: item.label,
            isSelected: isSelected,
            onTap: () => onItemSelected(index), // Callback when an item is tapped
          );
        }),
      ),
    );
  }
}

/// Individual item within the custom navigation bar.
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        curve: Curves.easeOutExpo,
        duration: Duration(milliseconds: 300),
        opacity: isSelected ? 1 : 0.7,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            vertical: context.screenWidth * 0.01,
            horizontal: context.screenWidth * 0.028,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Transform.scale(
            scale: isSelected ? 1 : 0.9,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(context.screenWidth * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: isSelected ? Color(0xffFEB454) : AppColors.white,
                  ),
                  child: Transform.scale(
                    scale: isSelected ? 1.35 : 0.8,

                    child: Icon(
                      icon,
                      color: isSelected ? AppColors.black : AppColors.darkerGrey,
                      size: 28,
                    ),
                  ),
                ),
                if (isSelected) ...[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.screenWidth * 0.01,
                        right: context.screenWidth * 0.01,
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? AppColors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
