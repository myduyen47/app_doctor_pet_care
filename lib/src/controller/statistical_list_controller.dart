import 'package:app_pet_care/src/model/statistical_model.dart';
import 'package:app_pet_care/src/service/statistical_services.dart';
import 'package:get/get.dart';

class StatisticalListController extends GetxController {
  RxList<StatisticalModel> liststatistical = <StatisticalModel>[].obs;

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
      await getStatisticalList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<StatisticalModel>> getStatisticalList(
      [int? selectedMonth]) async {
    try {
      final response = await StatisticalServices()
          .getStatistical(selectedMonth: selectedMonth);

      if (response.statusCode == 200) {
        final dynamic responseBody = response.body;
        print('Response Body: $responseBody');

        if (responseBody is Map<String, dynamic>) {
          // Check if it contains the "Invalid Date" message
          if (responseBody.containsKey('stringValue') &&
              responseBody.containsKey('valueType') &&
              responseBody['valueType'] == 'Date') {
            // Handle the case when the server returns an invalid date
            throw Exception(
                'Invalid date received from server: ${responseBody['stringValue']}');
          }

          final statisticalModel = StatisticalModel.fromJson(responseBody);

          liststatistical.value = [statisticalModel];
          return [statisticalModel];
        } else {
          throw Exception('Invalid data format: Response is not a Map');
        }
      } else {
        throw Exception(
            'Failed to load data! Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data!');
    }
  }

  Future<void> getStatisticalListByMonth(int selectedMonth) async {
    try {
      final List<StatisticalModel> result =
          await getStatisticalList(selectedMonth);
      liststatistical.value = result;
    } catch (e) {
      print(e.toString());
    }
  }
}
