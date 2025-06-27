// news_screen.dart
import 'package:clima_news/common/widgets/custom_appbar.dart';
import 'package:clima_news/common/widgets/shimmer/news_shimmer.dart';
import 'package:clima_news/features/news/controller/home/news_controller.dart';
import 'package:clima_news/features/news/screens/news/widget/news_list_widget.dart';
import 'package:clima_news/features/news/screens/news/widget/search_result_widget.dart';
import 'package:clima_news/features/news/screens/news/widget/trending_news_list.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final newsController = Get.put(NewsController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (newsController.newsForYouList.isEmpty) {
        newsController.getNewsForYou();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (newsController.isSearchActive.value &&
          !newsController.isMoreLoading.value &&
          newsController.searchResults.length < newsController.totalResults.value) {
        newsController.loadMoreSearchResults();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //-- Show shimmer only if both trending and news for you are loading
      if (newsController.trendingNewsList.isEmpty && newsController.newsForYouList.isEmpty) {
        return const NewsShimmer();
      }

      return Scaffold(
        appBar: CustomAppBar(
          leading: const SizedBox(),
          backgroundColor: AppColors.darkBackground,
          isCenterTitle: true,
          title: 'NEWSEEKERS',
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: AppColors.whiteText,
            fontSize: context.screenWidth * 0.07,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.all(context.screenWidth * 0.045),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchField(context),
                if (newsController.isSearchActive.value)
                  SearchResultsWidget(controller: newsController)
                else
                  _buildNormalContent(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(40),
      ),
      margin: EdgeInsets.only(top: context.screenHeight * 0.03),
      child: TextFormField(
        onFieldSubmitted: (value) => _performSearch(newsController),
        controller: newsController.searchController,
        cursorColor: AppColors.white,
        style: GoogleFonts.poppins(color: AppColors.white),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.white),
          ),
          prefixIcon: const Icon(Iconsax.search_normal, color: AppColors.white),
          suffixIcon:
              newsController.isSearchActive.value
                  ? IconButton(
                    icon: const Icon(Icons.close, color: AppColors.white),
                    onPressed: newsController.clearSearch,
                  )
                  : null,
          hintText: 'Search News...',
          hintStyle: GoogleFonts.poppins(color: AppColors.whiteText),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
        ),
      ),
    );
  }

  Widget _buildNormalContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: context.screenHeight * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hottest News",
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontSize: context.screenWidth * 0.037,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        //-- Show shimmer if trending news is still loading
        if (newsController.isLoading.value && newsController.trendingNewsList.isEmpty)
          SizedBox(
            height: context.screenHeight * 0.35,
            child: const Center(child: CircularProgressIndicator()),
          )
        else
          TrendingNewsList(trendingNewsList: newsController.trendingNewsList),

        Padding(
          padding: EdgeInsets.only(top: context.screenHeight * 0.03),
          child: Row(
            children: [
              Text(
                'News For You',
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontSize: context.screenWidth * 0.037,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        //-- Show shimmer if news for you is still loading
        if (newsController.isNewLoading.value && newsController.newsForYouList.isEmpty)
          SizedBox(
            height: context.screenHeight * 0.5,
            child: const Center(child: CircularProgressIndicator()),
          )
        else if (newsController.newsForYouList.isEmpty)
          SizedBox(
            height: context.screenHeight * 0.5,
            child: Center(
              child: Text(
                'No news available',
                style: GoogleFonts.poppins(color: AppColors.white),
              ),
            ),
          )
        else
          NewsListWidget(newsList: newsController.newsForYouList),
      ],
    );
  }

  void _performSearch(NewsController controller) {
    final query = controller.searchController.text.trim();
    if (query.isNotEmpty) {
      controller.searchNews(query);
    } else {
      controller.clearSearch();
    }
  }
}
