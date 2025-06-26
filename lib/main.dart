import 'package:clima_news/bindings/general_bindings.dart';
import 'package:clima_news/data/repositories/authentication/authenticaion_repository.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  //-- widgets binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //-- initialize getStorage
  await GetStorage.init();

  //--await until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //-- it remove the focus from the widget
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        initialBinding: GeneralBiniding(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(scaffoldBackgroundColor: AppColors.darkBackground),
        home: Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
