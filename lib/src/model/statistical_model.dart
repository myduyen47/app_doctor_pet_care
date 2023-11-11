class StatisticalModel {
  int? totalAppointments;
  int? totalRevenue;
  int? successfulAppointments;
  int? completedAppointments;
  int? cancelledAppointments;
  Map<String, int>? serviceStats;

  StatisticalModel({
    this.totalAppointments,
    this.totalRevenue,
    this.successfulAppointments,
    this.completedAppointments,
    this.cancelledAppointments,
    this.serviceStats,
  });

  factory StatisticalModel.fromJson(Map<String, dynamic> json) {
    return StatisticalModel(
      totalAppointments: json['totalAppointments'],
      totalRevenue: json['totalRevenue'],
      successfulAppointments: json['successfulAppointments'],
      completedAppointments: json['completedAppointments'],
      cancelledAppointments: json['cancelledAppointments'],
       serviceStats: json['serviceStats'] != null
        ? Map<String, int>.from(json['serviceStats'])
        : <String, int>{},
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAppointments'] = totalAppointments;
    data['totalRevenue'] = totalRevenue;
    data['successfulAppointments'] = successfulAppointments;
    data['completedAppointments'] = completedAppointments;
    data['cancelledAppointments'] = cancelledAppointments;
    data['serviceStats'] = serviceStats;
    return data;
  }
}
