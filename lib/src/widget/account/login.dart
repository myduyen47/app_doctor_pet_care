import 'package:app_pet_care/src/controller/login_controller.dart';
import 'package:app_pet_care/src/widget/_common/custom_clipper.dart';
import 'package:app_pet_care/src/widget/_common/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginDoctorController());
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Stack(
          children: [
            ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0072AD),
                      Color(0xFF0072AD),
                    ],
                  ),
                ),
              ),
            ),
            buildFormContainer(controller),
          ],
        ),
      ),
    ));
  }

  Widget buildFormContainer(LoginDoctorController controller) {
    return Center(
      child: Container(
        height: MediaQuery.of(Get.context!).size.height * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 233, 134, 123).withOpacity(0.8),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(
                        'lib/assets/image/login.png',
                        width: 300,
                        height: 150,
                      ),
                    ),
                  ),
                  Obx(
                    () => MyTextField(
                      controller: controller.usernameController,
                      focusNode: controller.usernameFocus,
                      labelText: 'Tài khoản:',
                      hintText: 'Nhập tài khoản của bạn',
                      textError: controller.usernameError.value,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(
                        Icons.person_outline_outlined,
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () => MyTextField(
                      controller: controller.passwordController,
                      focusNode: controller.passwordFocus,
                      labelText: 'Mật khẩu:',
                      hintText: 'Nhập mật khẩu của bạn',
                      textError: controller.passwordError.value,
                      textInputAction: TextInputAction.done,
                      obscureText: controller.isPasswordHidden.value,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        size: 26,
                      ),
                      suffixIcon: IconButton(
                        icon: Obx(
                          () => controller.isPasswordHidden.value
                              ? const Icon(
                                  Icons.visibility,
                                  size: 26,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  size: 26,
                                ),
                        ),
                        onPressed: () {
                          controller.togglePasswordHidden();
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Quên mật khẩu?',
                        style: GoogleFonts.sura(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        CustomButton(
                          text: 'Đăng nhập',
                          backgroundColor: const Color(0xFF0072AD),
                          width: 240,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hoặc',
                          style: GoogleFonts.sura(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/image/16.png',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 20),
                            Image.asset(
                              'lib/assets/image/18.png',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 20),
                            Image.asset(
                              'lib/assets/image/17.png',
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bạn chưa có tài khoản?',
                            style: GoogleFonts.sura(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Đăng ký',
                              style: GoogleFonts.sura(
                                textStyle: const TextStyle(
                                  color: Color(0xFF12609F),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double width;
  final Function() onPressed;

  const CustomButton({
    required this.text,
    required this.backgroundColor,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
