// search_results_widget.dart
import 'package:clima_news/common/widgets/shimmer/news_shimmer.dart';
import 'package:clima_news/features/news/controller/home/news_controller.dart';
import 'package:clima_news/features/news/screens/news/widget/news_list_widget.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchResultsWidget extends StatelessWidget {
  final NewsController controller;

  const SearchResultsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //-- showing shimmer till loading
      if (controller.isSearchLoading.value && controller.searchResults.isEmpty) {
        return const Center(child: NewsShimmer());
      }
      //-- showing text if no datas found
      if (controller.searchResults.isEmpty) {
        return Center(
          child: Text('No results found', style: GoogleFonts.poppins(color: AppColors.white)),
        );
      }

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.screenHeight * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //-- search result text
                Text(
                  AppStrings.searchResultText,
                  style: GoogleFonts.poppins(
                    color: AppColors.white,
                    fontSize: context.screenWidth * 0.037,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                //-- search result count
                Text(
                  '${controller.searchResults.length} of ${controller.totalResults.value} results',
                  style: GoogleFonts.poppins(
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          //-- newslist showing by search
          NewsListWidget(newsList: controller.searchResults),
          if (controller.isMoreLoading.value)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (controller.searchResults.length >= controller.totalResults.value &&
              controller.totalResults.value > 0)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'End of results',
                  style: GoogleFonts.poppins(color: AppColors.white),
                ),
              ),
            ),
        ],
      );
    });
  }
}
