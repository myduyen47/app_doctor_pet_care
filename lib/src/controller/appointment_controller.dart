import 'package:get/get.dart';

class AppointmentController extends GetxController {
    Rx<DateTime> selectedDate = DateTime.now().obs;
}