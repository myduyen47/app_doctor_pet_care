import 'package:app_pet_care/src/model/listpetowner_model.dart';
import 'package:app_pet_care/src/service/appointment_services.dart';
import 'package:get/get.dart';

class GetPetOwnerListController extends GetxController {
RxList<ListPetOwnerModel> listpet = <ListPetOwnerModel>[].obs;

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
        await getPetOwnerList();
      } catch (e) {
        print(e.toString());
      }
    }
  
    Future<List<ListPetOwnerModel>> getPetOwnerList() async {
      final response = await AppointmentServices().getAppointmentPetOwners();
      if (response.statusCode == 200) {
        final data = response.body;
        listpet.value = List<ListPetOwnerModel>.from(
            data.map((e) => ListPetOwnerModel.fromJson(e)));
        return listpet;
      } else {
        throw Exception('Failed to load data!');
      }
    }

}