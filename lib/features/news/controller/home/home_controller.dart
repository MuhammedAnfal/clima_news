import 'package:clima_news/features/news/models/weather_data.dart';
import 'package:clima_news/features/news/screens/home/widgets/fetch_weather_api.dart';
import 'package:clima_news/features/utils/popups/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  //-- variables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxString city = ''.obs;
  final Rx<WeatherData> weatherData = WeatherData().obs;
  final DateTime now = DateTime.now();
  RxInt currentIndex = 0.obs;
  final searchController = TextEditingController();
  final RxInt currentPage = 0.obs;
  final RxBool isSearching = false.obs;

  bool get isLoading => _isLoading.value;
  double get latitude => _latitude.value;
  double get longitude => _longitude.value;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    initLocation();
  }

  WeatherData getData() {
    return weatherData.value;
  }

  void clearSearch() {
    searchController.clear();
    isSearching.value = false;
    resetToCurrentLocation();
  }

  Future<void> resetToCurrentLocation() async {
    try {
      _isLoading.value = true;
      // Remove this line: it clears data before fetch completes
      // weatherData.value = WeatherData()

      await _getCurrentPosition();
    } catch (e) {
      _handleLocationError(e);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> searchWeatherByCity(String cityName) async {
    try {
      //-- start the function and make the loading is true
      _isLoading.value = true;
      isSearching.value = true;
      //-- getting the searched locaiton from the loactions
      List<Location> locations = await locationFromAddress(cityName);

      //-- throw not found it the loaction is empty

      if (locations.isEmpty) throw "Location not found";

      //-- get the first locaiton from the locations and assig the lat and long

      Location location = locations.first;
      print(location);
      print('2');
      _latitude.value = location.latitude;
      _longitude.value = location.longitude;

      //-- make function unde one await
      await Future.wait([
        //-- run the get address function to get the place
        getAddress(latitude, longitude),
        //-- fertch weather and assing the value to the weatherdata
        _fetchWeatherData(),
      ]);
    } catch (e) {
      //-- show the error through loaders
      Loaders.errorSnackBar(title: e.toString());
    } finally {
      //-- make the isloading value false
      _isLoading.value = false;
    }
  }

  Future<void> _fetchWeatherData() async {
    //--fetch weatherdata using fetchweather class
    final data = await FetchWeatherApi().processData(latitude, longitude);
    weatherData.value = data;
  }

  //-- handling the operation
  Future<void> initLocation() async {
    try {
      //-- conducting the function
      await _checkLocationPermissions();
      await _getCurrentPosition();
    } catch (e) {
      //-- handle the error
      _handleLocationError(e);
    } finally {
      //-- make the isloading value false
      _isLoading.value = false;
    }
  }

  //-- getting address using the lat and long
  Future<void> getAddress(double lat, double long) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        //-- set the valu to the variable
        city.value =
            placemarks.last.locality ??
            placemarks.first.subAdministrativeArea ??
            'Current Location';
      } else {
        city.value = 'Current Location';
      }
    } catch (e) {
      //-- handle the error if didnt get any place
      debugPrint('Error getting address: $e');
      city.value = 'Unknown location';
    }
    print(city.value);
    print('1');
  }

  //-- checking location permissions
  Future<void> _checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled. Please enable them.';
    }

    //-- check the permission and user get the location req

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //-- if denied checking again

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //-- if denied again thorw error show the permission is required

        throw 'Location permissions are required to use this feature.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //-- throw the error when the permission denied forever
      throw 'Location permissions are permanently denied. Please enable them in app settings.';
    }
  }

  //-- get current position
  Future _getCurrentPosition() async {
    //-- get current position while using geolocator
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    //-- assigning valus to the variables
    _latitude.value = position.latitude;
    _longitude.value = position.longitude;

    await getAddress(latitude, longitude);
    await _fetchWeatherData();
  }

  void _handleLocationError(dynamic error) {
    city.value = 'Current Location';
    //- show the snack bar
    debugPrint('Location error: $error');
    Get.snackbar('Location Error', error.toString(), snackPosition: SnackPosition.BOTTOM);
  }

  RxInt getIndex() {
    return currentIndex;
  }
}
