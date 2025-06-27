// trending_news_list.dart
import 'package:clima_news/features/news/models/news_model.dart';
import 'package:clima_news/features/news/screens/news/news_details_screen.dart';
import 'package:clima_news/features/news/screens/news/widget/trending_card.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendingNewsList extends StatelessWidget {
  final List<NewsModel> trendingNewsList;

  const TrendingNewsList({super.key, required this.trendingNewsList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trendingNewsList.length,
        itemBuilder: (context, index) {
          //-- showing trending news list
          final news = trendingNewsList[index];
          return TrendingCard(
            ontap:
                () => Get.to(
                  () => NewsDetailsScreen(
                    description: news.description ?? "",
                    imageUrl: news.urlToImage ?? "",
                    tag: 'Trending$index',
                    author: news.author ?? "Unknown",
                    time: DateTime.parse(news.publishedAt.toString()),
                    title: news.title ?? "",
                  ),
                ),
            imageUrl: news.urlToImage ?? "",
            tag: 'Trending$index',
            author: news.author ?? "Unknown",
            time: DateTime.parse(news.publishedAt.toString()),
            title: news.title ?? "",
          );
        },
      ),
    );
  }
}
