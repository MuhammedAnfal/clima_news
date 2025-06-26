// news_list_widget.dart
import 'package:clima_news/features/news/models/news_model.dart';
import 'package:clima_news/features/news/screens/news/news_details_screen.dart';
import 'package:clima_news/features/news/screens/news/widget/news_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsListWidget extends StatelessWidget {
  final List<NewsModel> newsList;

  const NewsListWidget({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        //-- list of news tiles

        final news = newsList[index];
        return NewsTile(
          ontap:
              () => Get.to(
                () => NewsDetailsScreen(
                  description: news.description ?? "",
                  imageUrl: news.urlToImage ?? "",
                  tag: 'news$index',
                  author: news.author ?? "Unknown",
                  time: DateTime.parse(news.publishedAt.toString()),
                  title: news.title ?? "",
                ),
              ),
          time: DateTime.parse(news.publishedAt.toString()),
          title: news.title ?? "",
          imageUrl: news.urlToImage ?? "",
          author: news.author ?? "Unknown",
        );
      },
    );
  }
}
