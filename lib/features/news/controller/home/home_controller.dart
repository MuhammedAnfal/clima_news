import 'package:clima_news/features/news/models/weather_data.dart';
import 'package:clima_news/features/news/screens/home/widgets/fetch_weather_api.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxString city = ''.obs;
  final Rx<WeatherData> weatherData = WeatherData().obs;
  final DateTime now = DateTime.now();
  RxInt currentIndex = 0.obs;
  final searchController = TextEditingController();

  bool get isLoading => _isLoading.value;
  double get latitude => _latitude.value;
  double get longitude => _longitude.value;

  @override
  void onInit() {
    super.onInit();
    if (_isLoading.isTrue) {
      _initLocation();
    } else {
      getIndex();
    }
  }

  WeatherData getData() {
    return weatherData.value;
  }

  //-- handling the operation
  Future<void> _initLocation() async {
    try {
      await _checkLocationPermissions();
      await getCurrentPosition();
    } catch (e) {
      _handleLocationError(e);
    } finally {
      _isLoading.value = false;
    }
  }

  //-- getting address using the lat and long

  Future<void> getAddress(double lat, double long) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        city.value = placemarks.last.locality ?? 'Unknown location';
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
      city.value = 'Unknown location';
    }
  }

  //-- checking location permissions
  Future<void> _checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled. Please enable them.';
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are required to use this feature.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied. Please enable them in app settings.';
    }
  }

  //-- get current position
  Future getCurrentPosition() async {
    print('1');

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    print('2');

    //-- assigning valus to the variables
    _latitude.value = position.latitude;
    _longitude.value = position.longitude;

    getAddress(latitude, longitude);
    print(_latitude);
    print(_longitude);
    print(searchController.text);
    print('3');

    // if (searchController.text.isEmpty) {
    print(searchController.text);
    print('4');
    //-- calling our weather api
    await FetchWeatherApi().processData(_latitude.value, _longitude.value).then((value) {
      print(value.current?.current.clouds);
      print(value.current?.current.clouds);
      print('5');
      weatherData.value = value;
      _isLoading.value = false;
      print(weatherData.value);
      print(isLoading);
      print('6');
    });
    // } else {
    //   print('else');
    //   await SearchWeatherApi().processData(_latitude.value, _longitude.value).then((value) {
    //     // print(value.current?.current.clouds);
    //     // print(value.current?.current.clouds);
    //     print('7');
    //     // weatherData.value = value;
    //     _isLoading.value = false;
    //     print(weatherData.value);
    //     print(isLoading);
    //     print('8');
    //   });
    // }
  }

  void _handleLocationError(dynamic error) {
    debugPrint('Location error: $error');
    Get.snackbar('Location Error', error.toString(), snackPosition: SnackPosition.BOTTOM);
  }

  RxInt getIndex() {
    return currentIndex;
  }
}
