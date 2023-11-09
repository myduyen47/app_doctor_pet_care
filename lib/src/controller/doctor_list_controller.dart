import 'dart:developer';

import 'package:app_pet_care/src/model/doctor_model.dart';
import 'package:app_pet_care/src/service/doctor_services.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:get/get.dart';

class DoctorListController extends GetxController {
  RxList<DoctorModel> listDoctor = <DoctorModel>[].obs;

  @override
    void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> init() async {
    try {
      await InfoDoctorList();
    } catch (e) {
      log(e.toString(),
          name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
    }
  }

  Future<List<DoctorModel>> InfoDoctorList() async {
    final response = await DoctorServices().getDoctorInfo();
    if (response.statusCode == 200) {
    final doctor = DoctorModel.fromJson(response.body);
    listDoctor.add(doctor);
    listDoctor.refresh();
    return listDoctor;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}