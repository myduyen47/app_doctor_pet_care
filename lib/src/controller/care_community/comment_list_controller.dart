import 'dart:developer';

import 'package:app_pet_care/src/model/page_model.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/comments_model.dart';
import '../../service/comments_services.dart';

class CommentListController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isFailedLoading = false.obs;
  final RxBool isLastPage = false.obs;
  final RxBool isMoreAvailable = false.obs;
  RxList<CommentModel> list = <CommentModel>[].obs;

  int page = 0;
  int limit = 15;
  String postId = '';
  CommentListController({required this.postId});
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    await init();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  Future<void> init() async {
    try {
      initState();
      await initList();
      await initPagination();
    } catch (e) {
      log(e.toString(),
          name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
      isFailedLoading.value = true;
    }
  }

  void initState() {
    isLoading.value = false;
    isFailedLoading.value = false;
    isLastPage.value = false;
    isMoreAvailable.value = false;
  }

  Future<void> initPagination() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isMoreAvailable.value != true) {
          if (isLastPage.value != true) {
            page++;
            loadMoreList();
          }
        }
      }
    });
  }

Future<void> initList() async {
  list.clear();
  page = 0;
  await CommentsService()
      .getCommentsList(page: page, limit: limit, postId: postId)
      .then((response) async {
    PageModel<CommentModel> page = await handleResponse(response);
    isLoading.value = false;
    isFailedLoading.value = false;
    isLastPage.value = page.hasNextPage != true;
    list.refresh();
  }).catchError((e) {
    isLoading.value = false;
    isFailedLoading.value = true;
    print(e.toString());
  });
}


Future<void> loadMoreList() async {
  isMoreAvailable.value = true;
  await CommentsService().getCommentsList(page: page, limit: limit, postId: postId).then(
      (response) async {
    PageModel<CommentModel> page = await handleResponse(response);
    isMoreAvailable.value = false;
    isFailedLoading.value = false;
    isLastPage.value = page.hasNextPage != true;
    list.refresh();
  }, onError: (_) {
    isMoreAvailable.value = false;
    isFailedLoading.value = true;
  });
}


  Future<PageModel<CommentModel>> handleResponse(
      Response<dynamic> response) async {
    if (response.statusCode != 200) {
      isLoading.value = false;
      isFailedLoading.value = true;
      return PageModel.noneData();
    }
    PageModel<CommentModel> page = PageModel<CommentModel>.fromJson(
        response.body, (json) => CommentModel.fromJson(json));
    for (var i = 0; i < page.docs.length; ++i) {
      list.add(page.docs[i]);
    }
    return page;
  }
}
