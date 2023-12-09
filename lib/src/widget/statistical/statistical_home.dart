import 'package:app_pet_care/src/controller/statistical_list_controller.dart';
import 'package:app_pet_care/src/model/statistical_model.dart';
import 'package:app_pet_care/src/widget/_common/frame_back.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

typedef void MonthSelectedCallback(int selectedMonth);

class StatisticalScreen extends StatefulWidget {
  final MonthSelectedCallback onMonthSelected;

  StatisticalScreen({Key? key, required this.onMonthSelected})
      : super(key: key);

  @override
  _StatisticalScreenState createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {
  int currentYear = DateTime.now().year;
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = DateTime.now().month;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticalListController());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const FrameBack(),
              const SizedBox(height: 20),
              // Hiển thị số năm hiện tại
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tháng $selectedMonth-$currentYear',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0072AD)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(12, (index) {
                    int month = index + 1;
                    String monthName =
                        DateFormat('MMMM').format(DateTime(currentYear, month));

                    // Kiểm tra nếu là tháng đã được chọn
                    bool isSelected = month == selectedMonth;

                    return GestureDetector(
                      onTap: () {
                        // Cập nhật tháng đã chọn khi người dùng nhấp vào
                        setState(() {
                          selectedMonth = month;
                        });
                        widget.onMonthSelected(selectedMonth);
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 124, 123, 123)),
                          borderRadius: BorderRadius.circular(8),
                          // Đổi màu nền khi tháng được chọn
                          color: isSelected ? const Color(0xFF0072AD) : null,
                        ),
                        child: Center(
                          child: Text(
                            monthName,
                            style: TextStyle(
                              fontSize: 16,
                              // Đổi màu chữ khi tháng được chọn
                              color: isSelected ? Colors.white : null,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Thống kê danh số',
                style: GoogleFonts.originalSurfer(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFA2AA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Tổng doanh thu',
                                      style: GoogleFonts.sura(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    FutureBuilder<List<StatisticalModel>>(
                                      future: controller
                                          .getStatisticalList(selectedMonth),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final revenue =
                                              snapshot.data![0].totalRevenue;
                                          final formattedRevenue =
                                              NumberFormat.currency(
                                            locale: 'vi_VN',
                                            symbol: '.000₫',
                                          ).format(revenue);
                                          return Text(
                                            '$formattedRevenue',
                                            style: GoogleFonts.originalSurfer(
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text('Chưa có dữ liệu');
                                        }
                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  ],
                                ))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0072AD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Số lượng lịch hẹn',
                                style: GoogleFonts.sura(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              FutureBuilder<List<StatisticalModel>>(
                                future: controller
                                    .getStatisticalList(selectedMonth),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      '${snapshot.data![0].totalAppointments}',
                                      style: GoogleFonts.originalSurfer(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Chưa có dữ liệu');
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  // biểu đồ thống kê sl dịch vụ
                  Container(
                    height: 460,
                    child: FutureBuilder<void>(
                      future: controller.init(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SfCircularChart(
                            title: ChartTitle(
                              text: 'Thống kê số lượng các dịch vụ được đặt',
                              textStyle: GoogleFonts.sura(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            legend: Legend(
                              isVisible: true,
                              height: '100%',
                              overflowMode: LegendItemOverflowMode.wrap,
                              textStyle: GoogleFonts.sura(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              position: LegendPosition.bottom,
                            ),
                            series: <CircularSeries>[
                              PieSeries<MapEntry<String, int>, String>(
                                dataSource: getData(),
                                xValueMapper: (MapEntry<String, int> data, _) =>
                                    data.key,
                                yValueMapper: (MapEntry<String, int> data, _) =>
                                    data.value,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('Chưa có dữ liệu');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  // biểu đồ thống kê trạng thái lịch hẹn
                  Container(
                    height: 400,
                    child: FutureBuilder<List<StatisticalModel>>(
                      future: controller.getStatisticalList(selectedMonth),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<StatisticalModel>? liststatistical =
                              controller.liststatistical;

                          if (liststatistical == null ||
                              liststatistical.isEmpty) {
                            return const Text('No data');
                          }

                          final StatisticalModel? statisticalModel =
                              liststatistical[0];

                          if (statisticalModel == null) {
                            return const Text('No data');
                          }

                          return SfCircularChart(
                            title: ChartTitle(
                              text: 'Thống kê số lượng trạng thái lịch hẹn',
                              textStyle: GoogleFonts.sura(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            legend: Legend(
                              isVisible: true,
                              height: '100%',
                              overflowMode: LegendItemOverflowMode.wrap,
                              textStyle: GoogleFonts.sura(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              position: LegendPosition.bottom,
                            ),
                            series: <CircularSeries>[
                              RadialBarSeries<Map<String, dynamic>, String>(
                                dataSource: [
                                  {
                                    'status': 'Đặt thành công',
                                    'value':
                                        statisticalModel.successfulAppointments,
                                  },
                                  {
                                    'status': 'Hoàn thành',
                                    'value':
                                        statisticalModel.completedAppointments,
                                  },
                                  {
                                    'status': 'Đã hủy',
                                    'value':
                                        statisticalModel.cancelledAppointments,
                                  },
                                ],
                                xValueMapper: (Map<String, dynamic> data, _) =>
                                    data['status'],
                                yValueMapper: (Map<String, dynamic> data, _) =>
                                    data['value'],
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('Chưa có dữ liệu');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<MapEntry<String, int>> getData() {
    final StatisticalListController controller =
        Get.find<StatisticalListController>();
    final List<StatisticalModel>? liststatistical = controller.liststatistical;

    if (liststatistical == null || liststatistical.isEmpty) {
      return [];
    }

    final StatisticalModel? statisticalModel = liststatistical[0];

    if (statisticalModel == null) {
      return [];
    }

    final Map<String, int>? serviceStats = statisticalModel.serviceStats;

    if (serviceStats == null) {
      return [];
    }
    return serviceStats.entries.toList();
  }
}
