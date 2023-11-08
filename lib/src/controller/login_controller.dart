import 'dart:developer';

import 'package:app_pet_care/src/service/account_services.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:app_pet_care/src/util/token_util.dart';
import 'package:app_pet_care/src/widget/home/home_dortor.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginDoctorController extends GetxController {
  // State
  RxBool isSubmitting = false.obs;

  // Form
  RxBool isFormValid = false.obs;

  onDataChanged() {
    isFormValid.value = usernameValid.value && passwordValid.value;
  }

  // Username
  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocus = FocusNode();
  RxString usernameError = ''.obs;
  RxBool usernameValid = false.obs;

  onUsernameChanged() {
    if (usernameController.text.isEmpty) {
      usernameError.value = 'Vui lòng nhập tên đăng nhập';
      usernameValid.value = false;
    } else {
      usernameError.value = '';
      usernameValid.value = true;
    }
    onDataChanged();
  }

  // Password
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  RxString passwordError = ''.obs;
  RxBool passwordValid = false.obs;
  RxBool isPasswordHidden = true.obs;

  onPasswordChanged() {
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Vui lòng nhập mật khẩu';
      passwordValid.value = false;
    } else {
      passwordError.value = '';
      passwordValid.value = true;
    }
    onDataChanged();
  }

  togglePasswordHidden() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  @override
  void onInit() {
    super.onInit();
    usernameController.addListener(onUsernameChanged);
    passwordController.addListener(onPasswordChanged);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    Get.closeAllSnackbars();
    isSubmitting.value = true;

    try {
      Response response = await AuthService().login(
        username: usernameController.text,
        password: passwordController.text,
      );
      log(response.body.toString(),
          name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
      if (response.statusCode == 200) {
        String? accessToken = response.body['accessToken'];

        if (accessToken != null) {
          await TokenUtil.setAccessToken(accessToken);
          log(accessToken, name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
          Get.snackbar('Thành công', 'Đăng nhập thành công!', backgroundColor: const Color(0xFFFF949D));
          Get.offAll(HomeDoctor());
          isSubmitting.value = false;
          return;
        }
        
        
      } else {
        Get.snackbar('Lỗi', 'Đăng nhập thất bại');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đăng nhập thất bại');
    } finally {
      isSubmitting.value = false;
    }
  }
}
