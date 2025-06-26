import 'package:clima_news/data/repositories/authentication/authenticaion_repository.dart';
import 'package:clima_news/data/repositories/user/user_repository.dart';
import 'package:clima_news/features/authentication/models/user_model.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/constants/sizes.dart';
import 'package:clima_news/features/utils/popups/full_screen_loader.dart';
import 'package:clima_news/features/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final hidePassword = false.obs;
  final imageUploading = false.obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  //-- get userData
  fetchUserData() async {
    profileLoading.value = true;
    try {
      final users = await userRepository.fetchUserDetails();

      user(users);
      user.refresh();
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //-- save user record from any register provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    //-- refresh user records
    await fetchUserData();
    try {
      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          //-- convert name to first and lastname
          final nameParts = UserModel.nameParts(
            userCredential.user!.displayName ?? '',
          );

          //mapData
          UserModel userData = UserModel(
            id: userCredential.user!.uid,
            email: userCredential.user!.email.toString() ?? '',

            profilePicture: userCredential.user!.photoURL ?? "",
            fullName: '',
            password: '',
          );

          //-- save userData
          await UserRepository.instance.saveUserRecord(userData);
        }
      }
    } catch (e) {
      Loaders.warningSnackBar(
        title: 'On Snap!',
        message:
            'Something went wrong while saving your infermation, You can re-save your data in your profile.',
      );
    }
  }

  // Future uploadProfilePicture() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 70,
  //       maxHeight: 512,
  //       maxWidth: 512,
  //     );
  //     if (image != null) {
  //       imageUploading.value = true;
  //       final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);
  //       Map<String, dynamic> json = {'profilePicture': image};
  //       userRepository.updateSingleField(json);
  //       user.value.profilePicture = imageUrl;
  //       user.refresh();
  //       Loaders.successSnackBar(
  //         title: 'Congratulation',
  //         message: 'Your profile has been updated',
  //       );
  //     }
  //   } catch (e) {
  //     Loaders.errorSnackBar(
  //       title: 'Oh snap!',
  //       message: 'Something Went Wrong: ${e.toString()}',
  //     );
  //   } finally {
  //     imageUploading.value = false;
  //   }
  // }
}
