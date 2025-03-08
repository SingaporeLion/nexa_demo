import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/account/profile_response_model.dart' as profile_model;
import 'package:nexa/data/model/account/profile_response_model.dart';
import 'package:nexa/data/model/profile/edit_profile/user_post_model.dart';
import 'package:nexa/data/model/user/user.dart';
import 'package:nexa/data/repo/profile/user_profile_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class UserProfileController extends GetxController {
  UserProfileRepo userProfileRepo;
  UserProfileController({required this.userProfileRepo});

  profile_model.ProfileResponseModel model = profile_model.ProfileResponseModel();

  String imageStaticUrl = '';
  bool isProfileComplete = false;

  bool user2faIsOne = false;

  List<String> errors = [];

  bool isLoading = true;
  bool isSubmit = false;

  String username = "";
  String email = "";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  File? imageFile;

  loadProfileInfo() async {
    isLoading = true;
    isSubmit = false;
    update();
    model = await userProfileRepo.loadProfileInfo();
    if (model.data != null && model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
      loadData(model);
    } else {
      isLoading = false;
      update();
    }
  }

  updateProfile() async {
    String firstName = firstNameController.text;
    email = emailController.text;
    String lastName = lastNameController.text;
    String address = addressController.text;
    String city = cityController.text;
    String zip = zipCodeController.text;
    String state = stateController.text;
    User? user = model.data?.user;

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      isSubmit = true;
      update();

      UserPostModel model = UserPostModel(firstname: firstName, lastName: lastName, mobile: user?.mobile ?? '', email: user?.email ?? '', username: user?.username ?? '', countryCode: user?.countryCode ?? '', country: user?.countryName ?? '', mobileCode: '880', image: imageFile, address: address, state: state, zip: zip, city: city);

      bool b = await userProfileRepo.updateProfile(model, true);

      if (b) {
        await loadProfileInfo();
      }
      isSubmit = false;
      update();
    } else {
      if (firstName.isEmpty) {
        CustomSnackBar.showCustomSnackBar(errorList: [MyStrings.kFirstNameNullError.tr], msg: [], isError: true);
      }
      if (lastName.isEmpty) {
        CustomSnackBar.showCustomSnackBar(errorList: [MyStrings.kLastNameNullError.tr], msg: [], isError: true);
      }
    }
  }

  String countryName = '';
  String telegramUsername = '';

  void loadData(ProfileResponseModel? model) {
    username = model?.data?.user?.username ?? '';
    email = model?.data?.user?.email ?? '';
    countryName = model?.data?.user?.countryName ?? '';

    firstNameController.text = model?.data?.user?.firstname ?? '';
    userProfileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${model?.data?.user?.username}');
    lastNameController.text = model?.data?.user?.lastname ?? '';
    emailController.text = model?.data?.user?.email ?? '';
    mobileNoController.text = model?.data?.user?.mobile ?? '';
    addressController.text = model?.data?.user?.address ?? '';
    stateController.text = model?.data?.user?.state ?? '';
    zipCodeController.text = model?.data?.user?.address ?? '';
    cityController.text = model?.data?.user?.address ?? '';
    user2faIsOne = model?.data?.user?.ts == '1' ? true : false;
    isLoading = false;

    update();
  }
}
