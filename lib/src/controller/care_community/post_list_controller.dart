import 'dart:developer';
import 'package:app_pet_care/src/model/page_model.dart';
import 'package:app_pet_care/src/model/post_model.dart';
import 'package:app_pet_care/src/service/post_services.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostListController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isFailedLoading = false.obs;
  final RxBool isLastPage = false.obs;
  final RxBool isMoreAvailable = false.obs;
  RxList<PostModel> list = <PostModel>[].obs;

  int page = 0;
  int limit = 15;
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
    isLoading.value = true;
    await PostServices()
        .getPostList(page: page, limit: limit)
        .then((res) async {
      PageModel<PostModel> page = await handleResponse(res);
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
    await PostServices().getPostList(page: page, limit: limit).then(
        (res) async {
      PageModel<PostModel> page = await handleResponse(res);
      isMoreAvailable.value = false;
      isFailedLoading.value = false;
      isLastPage.value = page.hasNextPage != true;
      list.refresh();
    }, onError: (_) {
      isMoreAvailable.value = false;
      isFailedLoading.value = true;
    });
  }

  Future<PageModel<PostModel>> handleResponse(
      Response<dynamic> response) async {
    if (response.statusCode != 200) {
      isLoading.value = false;
      isFailedLoading.value = true;
      return PageModel.noneData();
    }
    PageModel<PostModel> page =
        PageModel<PostModel>.fromJson(response.body, (json) {
      return PostModel.fromJson(json);
    });

    for (var i = 0; i < page.docs.length; ++i) {
      list.add(page.docs[i]);
    }
    return page;
  }

  Future<void> updateReactPost(String postId) async {
    try{
      await PostServices().updateReactPost(postId);
      refresh();
    }catch(e){
      print(e.toString());
    }
  }
}
