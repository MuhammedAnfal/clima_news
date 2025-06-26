import 'package:clima_news/common/widgets/custom_appbar.dart';
import 'package:clima_news/common/widgets/shimmer/news_shimmer.dart';
import 'package:clima_news/features/news/controller/home/news_controller.dart';
import 'package:clima_news/features/news/screens/news/news_details_screen.dart';
import 'package:clima_news/features/news/screens/news/widget/news_tile.dart';
import 'package:clima_news/features/news/screens/news/widget/trending_card.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          newsController.trendingNewsList.isEmpty
              ? NewsShimmer()
              : Scaffold(
                appBar: CustomAppBar(
                  leading: SizedBox(),
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
                    padding: EdgeInsets.all(context.screenWidth * 0.045),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //-- hottest news text and see all text
                          Row(
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
                              Text(
                                AppStrings.seeAllText,
                                style: GoogleFonts.poppins(
                                  color: AppColors.darkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          //-- Trending news list
                          SizedBox(
                            height: context.screenHeight * 0.35,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: newsController.trendingNewsList.length,
                              itemBuilder: (context, index) {
                                return TrendingCard(
                                  ontap:
                                      () => Get.to(
                                        () => NewsDetailsScreen(
                                          description:
                                              newsController
                                                  .trendingNewsList[index]
                                                  .description
                                                  .toString(),
                                          imageUrl:
                                              newsController
                                                  .trendingNewsList[index]
                                                  .urlToImage
                                                  .toString(),
                                          tag: 'Trending',
                                          author:
                                              newsController
                                                  .trendingNewsList[index]
                                                  .author
                                                  .toString() ??
                                              "Unknown",
                                          time: DateTime.parse(
                                            newsController
                                                .trendingNewsList[index]
                                                .publishedAt
                                                .toString(),
                                          ),
                                          title:
                                              newsController
                                                  .trendingNewsList[index]
                                                  .title
                                                  .toString(),
                                        ),
                                      ),
                                  imageUrl:
                                      newsController
                                          .trendingNewsList[index]
                                          .urlToImage
                                          .toString(),
                                  tag: 'Trending',
                                  author:
                                      newsController
                                          .trendingNewsList[index]
                                          .author
                                          .toString() ??
                                      "Unknown",
                                  time: DateTime.parse(
                                    newsController
                                        .trendingNewsList[index]
                                        .publishedAt
                                        .toString(),
                                  ),
                                  title:
                                      newsController
                                          .trendingNewsList[index]
                                          .title
                                          .toString(),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: context.screenHeight * 0.03,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'News For You',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.white,
                                    fontSize: context.screenWidth * 0.037,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  AppStrings.seeAllText,
                                  style: GoogleFonts.poppins(
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: context.screenHeight * 0.5,
                            child: ListView.builder(
                              itemCount: newsController.newsForYouList.length,
                              itemBuilder: (context, index) {
                                return NewsTile(
                                  ontap:
                                      () => Get.to(
                                        () => NewsDetailsScreen(
                                          description:
                                              newsController
                                                  .trendingNewsList[index]
                                                  .description
                                                  .toString(),
                                          imageUrl:
                                              newsController
                                                  .trendingNewsList[index]
                                                  .urlToImage
                                                  .toString(),
                                          tag: 'Trending',
                                          author:
                                              newsController
                                                  .trendingNewsList[index]
                                                  .author
                                                  .toString() ??
                                              "Unknown",
                                          time: DateTime.parse(
                                            newsController
                                                .trendingNewsList[index]
                                                .publishedAt
                                                .toString(),
                                          ),
                                          title:
                                              newsController
                                                  .trendingNewsList[index]
                                                  .title
                                                  .toString(),
                                        ),
                                      ),
                                  time: DateTime.parse(
                                    newsController
                                        .newsForYouList[index]
                                        .publishedAt
                                        .toString(),
                                  ),
                                  title:
                                      newsController.newsForYouList[index].title
                                          .toString(),
                                  imageUrl:
                                      newsController
                                          .newsForYouList[index]
                                          .urlToImage
                                          .toString(),
                                  author:
                                      newsController
                                          .newsForYouList[index]
                                          .author
                                          .toString() ??
                                      'Unknown',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
    );
  }
}
