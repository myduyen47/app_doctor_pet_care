import 'dart:convert';
import 'dart:io';
import 'package:app_pet_care/src/widget/post/care_community_home.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/doctor_model.dart' as DoctorModel;
import '../../model/post_model.dart' as PostModel;
import '../../model/image_model.dart';

import '../../service/file_services.dart';
import '../../service/post_services.dart';
import '../doctor_list_controller.dart';

class PostController extends GetxController {
  RxList<imageModel> files = <imageModel>[].obs;

  RxBool isFormValid = false.obs;

  TextEditingController contentPostController = TextEditingController();

  void addImage(imageModel image) {
    if (files.isNotEmpty) {
      files.clear();
    }
    files.add(image);
  }

  void removeImage(imageModel image) {
    files.remove(image);
    files.refresh();
  }

  void changeImage(imageModel newImage) {
    files.clear();
    files.add(newImage);
    files.refresh();
  }

  void onSelectNewImage(imageModel newImage) {
    files.refresh();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    contentPostController.dispose();
    super.onClose();
  }

  void clear() {
    contentPostController.clear();
    files.clear();
  }

  Future<void> createPost() async {
    Get.closeAllSnackbars();
    try {
      print('Files before upload: ${files}');
      final List<imageModel> uploadedImages =
          files.isNotEmpty ? await uploadImages() : <imageModel>[];

      String content = contentPostController.text;
      final DoctorModel.DoctorModel user =
        Get.find<DoctorListController>().listDoctor.first;

      print('Content: $content');
      print('Uploaded images: $uploadedImages');

       final PostModel.PostModel postModel = PostModel.PostModel(
      content: content,
      avatar: PostModel.Avatar(
        url: uploadedImages.isNotEmpty ? uploadedImages[0].path : '',
      ),
      user: PostModel.User(
        id: user.id,
        name: user.fullName,
        avatar: user.avatar?.link != null
            ? PostModel.Avatar(url: user.avatar!.link!)
            : PostModel.Avatar(url: ''),
      ),
    );
      PostServices().createPost(postModel).then((response) {
        print('Response: ${response.body}');
        if (response.statusCode == 201) {
          Get.snackbar(
            'Thành công',
            'Đăng bài thành công!',
            backgroundColor: const Color(0xFFFF949D),
          );
          Get.to(PagesSceen());
          clear();
        } else {
          Get.snackbar(
            'Lỗi',
            'Đăng bài thất bại',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }).catchError((e) {
        print('Lỗi đăng bài: $e');
        Get.snackbar(
          'Lỗi',
          'Đăng bài thất bại',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });
    } catch (e) {
      print('Lỗi đăng bài: $e');
      Get.snackbar(
        'Lỗi',
        'Đăng bài thất bại',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<List<imageModel>> uploadImages() async {
    try {
      List<imageModel> uploadedImages = <imageModel>[];

      for (final imageModel image in files) {
        print('Uploading image: ${image.path}');
        final http.StreamedResponse response = await FileService().upload(
          File(image.path),
        );
        final statusCode = response.statusCode;
        final responseString = await response.stream.bytesToString();
        print('Upload ảnh: $responseString');

        if (statusCode == 200) {
          if (responseString != null && responseString.isNotEmpty) {
            final Map<String, dynamic> responseData =
                jsonDecode(responseString);
            print('Response data: $responseData');
            uploadedImages.add(imageModel.fromJson(responseData));
            print(
                'Upload ảnh thành công: ${imageModel.fromJson(responseData)}');
          } else {
            print('responseString is null or empty');
          }
        } else {
          print(
              'Lỗi upload ảnh. Status Code: $statusCode, Response: $responseString');
        }
      }
      return uploadedImages;
    } catch (e) {
      print('Lỗi upload ảnh: $e');
      throw e;
    }
  }
}
