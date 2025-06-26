import 'dart:convert';

import 'package:clima_news/features/news/models/news_model.dart';
import 'package:clima_news/features/utils/constants/api_constants.dart';
import 'package:clima_news/features/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  //-- variables
  RxBool isNewLoading = false.obs;
  RxBool isLoading = false.obs;
  RxList<NewsModel> trendingNewsList = <NewsModel>[].obs;
  RxList<NewsModel> newsForYouList = <NewsModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTrendingNews();
    getNewsForYou();
  }

  Future getTrendingNews() async {
    try {
      isLoading.value = true;
      var baseUrl =
          "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$newsApiKey";
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        //-- Extract the "articles" list of  the response
        List<dynamic> articles = jsonData["articles"];
        //-- adding to the tredinglists
        for (var news in articles) {
          trendingNewsList.add(
            NewsModel.fromJson(news as Map<String, dynamic>),
          );
        }
        return trendingNewsList;
      }
    } catch (e) {
      isLoading.value = false;
      Loaders.errorSnackBar(
        title: 'Oh Snap!',
        message: "error: Something went wrong",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future getNewsForYou() async {
    try {
      isLoading.value = true;
      var baseUrl =
          "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=$newsApiKey";
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        print('0');

        //-- Extract the "articles" list of  the response
        List<dynamic> articles = jsonData["articles"];
        print('1');

        //-- adding to the tredinglists
        for (var news in articles) {
          newsForYouList.add(NewsModel.fromJson(news as Map<String, dynamic>));
        }
        print(newsForYouList);
        print('2');
        return trendingNewsList;
      }
    } catch (e) {
      isLoading.value = false;
      print('error:$e');
      Loaders.errorSnackBar(
        title: 'Oh Snap!',
        message: "error: Something went wrong",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
