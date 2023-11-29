import 'package:app_pet_care/src/controller/doctor_list_controller.dart';
import 'package:app_pet_care/src/model/doctor_model.dart' as DoctorModel;
import 'package:app_pet_care/src/service/comments_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/comments_model.dart';

class CommentController extends GetxController {
  TextEditingController commentTextController = TextEditingController();

  @override
  void onClose() {
    commentTextController.dispose();
    super.onClose();
  }

  void clear() {
    commentTextController.clear();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> createComment({required String postId}) async {
    print('postId in createComment: $postId');
    Get.closeAllSnackbars();
    try {
      String comment = commentTextController.text;
      final DoctorModel.DoctorModel user =
          Get.find<DoctorListController>().listDoctor.first;

      print('Comment: ${comment}');

      CommentsService()
          .createComments(
              content: comment,
              postId: postId,
              user: User(
                id: user.id,
                name: user.fullName,
                avatar: Avatar(
                  url: user.avatar!.link ?? '',
                ),
              ))
          .then((response) {
        print('Response: ${response.body}');
        if (response.statusCode == 201) {
          Get.back(result: {'isReload': true});
          clear();
        } else {
          Get.snackbar('Error', 'Error creating comment',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          clear();
        }
      }).catchError((e) {
        print('Error: ${e.toString()}');
        Get.snackbar('Error', 'Error creating comment',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      });
    } catch (e) {
      print('Error: ${e.toString()}');
      Get.snackbar('Error', 'Error creating comment',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
