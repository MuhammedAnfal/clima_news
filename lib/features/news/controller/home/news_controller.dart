// news_controller.dart
import 'dart:convert';
import 'package:clima_news/features/news/models/news_model.dart';
import 'package:clima_news/features/utils/constants/api_constants.dart';
import 'package:clima_news/features/utils/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  //-- variables
  RxBool isNewLoading = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSearchLoading = false.obs;
  RxBool isMoreLoading = false.obs;
  RxList<NewsModel> trendingNewsList = <NewsModel>[].obs;
  RxList<NewsModel> newsForYouList = <NewsModel>[].obs;
  RxList<NewsModel> searchResults = <NewsModel>[].obs;
  RxBool isSearchActive = false.obs;
  RxInt currentPage = 1.obs;
  RxInt totalResults = 0.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getTrendingNews();
    getNewsForYou();
  }

  void clearSearch() {
    searchController.clear();
    searchResults.clear();
    isSearchActive.value = false;
    currentPage.value = 1;
    totalResults.value = 0;
  }

  Future<void> searchNews(String query) async {
    //--start function and make the loading value is true

    isSearchLoading.value = true;

    //-- make the current page is 1

    currentPage.value = 1;
    try {
      //-- setting base url and fetching

      var baseUrl =
          "https://newsapi.org/v2/everything?q=$query&pageSize=10&page=1&apiKey=$newsApiKey";
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        //-- if the response is success make its decode

        var body = jsonDecode(response.body);

        //-- get the total results

        totalResults.value = body['totalResults'] ?? 0;

        //-- get the articles from the datas

        var articles = body['articles'];
        searchResults.clear();
        for (var news in articles) {
          //-- adding newsed to the lists

          searchResults.add(NewsModel.fromJson(news));
        }

        //-- make the loading value

        isSearchActive.value = true;
      }
    } catch (e) {
      Loaders.errorSnackBar(title: "Search Failed", message: 'Error: $e');
    } finally {
      //-- when finally the loading make false

      isSearchLoading.value = false;
    }
  }

  Future<void> loadMoreSearchResults() async {
    //-- start the function for  fetch more data
    if (isMoreLoading.value || searchResults.length >= totalResults.value) return;

    //-- make the loading start and set the page value up

    isMoreLoading.value = true;
    currentPage.value++;
    try {
      var baseUrl =
          "https://newsapi.org/v2/everything?q=${searchController.text}&pageSize=10&page=${currentPage.value}&apiKey=$newsApiKey";
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        //-- if the response is success make its decode

        var body = jsonDecode(response.body);

        //-- get the articles from the datas

        var articles = body['articles'];

        for (var news in articles) {
          //-- adding the newses to search result
          searchResults.add(NewsModel.fromJson(news));
        }
      }
    } catch (e) {
      //-- show the error snack if any error occures

      Loaders.errorSnackBar(title: "Oh Snap!", message: 'Error: $e');
      currentPage.value--;
    } finally {
      //-- make the loading value false

      isMoreLoading.value = false;
    }
  }

  Future getTrendingNews() async {
    //-- start the function for get trending newses
    try {
      //-- make the loading start
      isLoading.value = true;
      //-- setting base url and fetching
      var baseUrl =
          "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$newsApiKey";
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        //-- if the response is success make its decode
        var jsonData = jsonDecode(response.body);
        //-- get the articles from the datas
        List<dynamic> articles = jsonData["articles"];

        //-- make thetrending list clear before adding

        trendingNewsList.clear();
        for (var news in articles) {
          //-- adding the news data to trendinglists
          trendingNewsList.add(NewsModel.fromJson(news as Map<String, dynamic>));
        }
      }
    } catch (e) {
      //-- sett the loading value false  and showing snackbar of the error
      isLoading.value = false;
      Loaders.errorSnackBar(title: 'Oh Snap!', message: "error: Something went wrong");
    } finally {
      //-- finally sett the loading false
      isLoading.value = false;
    }
  }

  Future getNewsForYou() async {
    //--starting the function getting newses for you
    try {
      //-- starting the  the boolean value true
      isNewLoading.value = true;

      //-- setting the base url
      var baseUrl =
          "https://newsapi.org/v2/everything?q=technology&pageSize=10&apiKey=$newsApiKey";
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        //-- decoding the data from response if the status code is 200
        var jsonData = jsonDecode(response.body);

        //-- setting up the articles from the data
        List<dynamic> articles = jsonData["articles"];

        //-- make sure its clear before adding the value
        newsForYouList.clear();
        for (var news in articles) {
          //-- adding the newses to the list
          newsForYouList.add(NewsModel.fromJson(news as Map<String, dynamic>));
        }
      }
    } catch (e) {
      //--  set the loading  value false and the showing the error snack bar
      isNewLoading.value = false;
      Loaders.errorSnackBar(title: 'Oh Snap!', message: "error: Something went wrong");
    } finally {
      //-- finally set the loading  value false
      isNewLoading.value = false;
    }
  }
}
