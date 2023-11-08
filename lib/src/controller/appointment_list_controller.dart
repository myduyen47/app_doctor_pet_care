import 'dart:developer';
import 'package:app_pet_care/src/model/appointment_model.dart';
import 'package:app_pet_care/src/model/page_model.dart';
import 'package:app_pet_care/src/service/appointment_services.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:app_pet_care/src/widget/_common/show_notification.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppointmentListController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isFailedLoading = false.obs;
  final RxBool isLastPage = false.obs;
  final RxBool isMoreAvailable = false.obs;
  RxList<AppointmentModel> list = <AppointmentModel>[].obs;

  int page = 0;
  int limit = 15;
  ScrollController scrollController = ScrollController();

  String selectedStatus = '';
  @override
  void onInit() async {
    super.onInit();
    selectedStatus = '2';
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
    await AppointmentServices()
        .getAppointmentListDoctor(page: page, limit: limit, status: selectedStatus)
        .then((res) async {
      PageModel<AppointmentModel> page = await handleResponse(res);
      isLoading.value = false;
      isFailedLoading.value = false;
      isLastPage.value = page.hasNextPage != true;
      list.refresh();
    }).catchError((error) {
      print(error);
      isLoading.value = false;
      isFailedLoading.value = true;
    });
  }

  Future<void> loadMoreList() async {
    isMoreAvailable.value = true;
    await AppointmentServices()
        .getAppointmentListDoctor(page: page, limit: limit, status: selectedStatus)
        .then((res) async {
      PageModel<AppointmentModel> page = await handleResponse(res);
      isMoreAvailable.value = false;
      isFailedLoading.value = false;
      isLastPage.value = page.hasNextPage != true;
      list.refresh();
    }, onError: (_) {
      isMoreAvailable.value = false;
      isFailedLoading.value = true;
    });
  }

  Future<PageModel<AppointmentModel>> handleResponse(
      Response<dynamic> response) async {
    if (response.statusCode != 200) {
      isLoading.value = false;
      isFailedLoading.value = true;
      return PageModel.noneData();
    }
    PageModel<AppointmentModel> page =
        PageModel.fromJson(response.body, (json) {
      return AppointmentModel.fromJson(json);
    });
    for (var i = 0; i < page.docs.length; ++i) {
      list.add(page.docs[i]);
    }
    return page;
  }

  //cập nhật trạng thái
  Future<void> updateStatus({required String status, String? id}) async {
    isLoading.value = true;
    await AppointmentServices().updateStatus(status: status, id: id).then((res) {
      isLoading.value = false;
      isFailedLoading.value = false;
      init();
       return true;
    }).catchError((error) {
      isLoading.value = false;
      isFailedLoading.value = true;
      Get.dialog(buildNotification(
        'Thất bại',
        'Vui lòng thử lại sau !!!',
      ));
      Future.delayed(const Duration(seconds: 5), () {
        Get.back();
      });
    });
  }



}
