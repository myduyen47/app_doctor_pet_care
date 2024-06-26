import 'dart:convert';

import 'package:app_pet_care/src/controller/getpetowner_list_controller.dart';
import 'package:app_pet_care/src/model/listpetowner_model.dart';
import 'package:app_pet_care/src/widget/_common/form_history.dart';
import 'package:app_pet_care/src/widget/_common/frame_back.dart';
import 'package:app_pet_care/src/widget/_common/frame_detail_info.dart';
import 'package:app_pet_care/src/widget/_common/frame_detail_pet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailMedicalRecordScreen extends StatelessWidget {
  const DetailMedicalRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final pet = arguments['pet'] as Pet;
    final user = arguments['user'];
    final controller = Get.put(GetPetOwnerListController());

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFD1E2F0),
      body: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FrameBack(),
              Text(
                pet.name!,
                style: GoogleFonts.sura(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 70,
                height: 70,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          pet.avatar!.link!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 5,
                color: const Color(0xFFFFE3D8),
              ),
              const SizedBox(height: 15),
              TabBar(
                tabs: const [
                  Tab(
                    child: Text('Thông tin cá nhân',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  Tab(
                    child: Text(
                      'Lịch sử lịch hẹn',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Sổ sức khỏe',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
                labelStyle: GoogleFonts.sura(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                )),
                unselectedLabelStyle: GoogleFonts.sura(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                indicatorColor: Colors.blue,
                isScrollable: true,
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          FrameDetailPeople(
                            name: user!.fullName!,
                            email: user.email!,
                            phone: user.phone ?? 'N/A',
                            address: user.address.detail! ?? 'N/A',
                          ),
                          FormDetailPet(
                            age: calculateAge(pet.birthDate!),
                            type: pet.type!.name!,
                            birthday: DateFormat('dd-MM-yyyy')
                                .format(DateTime.parse(pet.birthDate!)),
                            weight: '${pet.weight!.toString()} kg',
                            color: pet.color!,
                            description: pet.describe ?? 'N/A',
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          FutureBuilder<List<ListPetOwnerModel>>(
                            future: controller.getPetOwnerList(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final List<ListPetOwnerModel> petOwnerList =
                                    snapshot.data!;

                                final List<ListPetOwnerModel>
                                    matchingPetOwners = petOwnerList.where(
                                  (element) {
                                    print('Pet ID: ${pet.id}');
                                    return element.pet != null &&
                                        element.pet!.id == pet.id &&
                                        element.appointments != null &&
                                        element.appointments!.isNotEmpty;
                                  },
                                ).toList();

                                if (matchingPetOwners.isEmpty) {
                                  return const Center(
                                      child: Text('Pet owner not found'));
                                }

                                final List<Map<String, dynamic>>
                                    filteredAppointmentDataList = [];

                                for (final petOwner in matchingPetOwners) {
                                  for (final appointment
                                      in petOwner.appointments!) {
                                    if (appointment.status == 3) {
                                      filteredAppointmentDataList.add({
                                        'status': appointment.status,
                                        'service': appointment.service,
                                        'appointmentDate':
                                            appointment.appointmentDate,
                                      });
                                    }
                                  }
                                }
                                if (filteredAppointmentDataList.isEmpty) {
                                  return const Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(top: 160),
                                    child: Text(
                                        'Không có lịch hẹn cho thú cưng này'),
                                  ));
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: filteredAppointmentDataList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final appointmentData =
                                        filteredAppointmentDataList[index];
                                    DateTime sendDate = DateTime.parse(
                                            appointmentData['appointmentDate'])
                                        .add(const Duration(hours: 7));
                                    String dayOfWeek = sendDate.weekdayName;
                                    String date =
                                        '${dayOfWeek.toString()}, ${DateFormat('dd-MM-yyyy').format(sendDate)}';
                                    String time =
                                        DateFormat('HH:mm').format(sendDate);
                                    return FormHistory(
                                      services:
                                          appointmentData['service']?.name ??
                                              '',
                                      date: date,
                                      time: time,
                                      image: 'lib/assets/image/PetPalace.png',
                                      onPressed: () {},
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      'Tiêm ngừa vaccine',
                                      style: GoogleFonts.sura(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 10),
                                  FutureBuilder<List<ListPetOwnerModel>>(
                                    future: controller.getPetOwnerList(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final List<ListPetOwnerModel>
                                            petOwnerList = snapshot.data!;

                                        final List<ListPetOwnerModel>
                                            matchingPetOwners =
                                            petOwnerList.where(
                                          (element) {
                                            print('Pet ID: ${pet.id}');
                                            return element.pet != null &&
                                                element.pet!.id == pet.id &&
                                                element.health != null &&
                                                element.health!.isNotEmpty;
                                          },
                                        ).toList();

                                        if (matchingPetOwners.isEmpty) {
                                          return const Center(
                                              child:
                                                  Text('Pet owner not found'));
                                        }

                                        final List<Map<String, dynamic>>
                                            filteredHealthDataList = [];

                                        for (final petOwner
                                            in matchingPetOwners) {
                                          for (final healthData
                                              in petOwner.health!) {
                                            if (healthData.type == 1) {
                                              filteredHealthDataList.add({
                                                'type': healthData.type,
                                                'data': json
                                                    .decode(healthData.data!),
                                              });
                                            }
                                          }
                                        }

                                        if (filteredHealthDataList.isEmpty) {
                                          return const Center(
                                              child: Text(
                                                  'Chưa có dữ liệu sức khỏe cho thú cưng này'));
                                        }

                                        return Column(
                                          children: filteredHealthDataList
                                              .map((healthData) {
                                            final Map<String, dynamic> data =
                                                healthData['data'];

                                            return Card(
                                              color: Colors.white,
                                              margin: const EdgeInsets.all(10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: const BorderSide(
                                                  color: Color(0xFF12609F),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .calendar_month_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 28,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  data[
                                                                      "Ngày tiêm"],
                                                                  style:
                                                                      GoogleFonts
                                                                          .sura(
                                                                    color: Colors
                                                                        .black,
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Vaccine: ${data["vaccine"]}',
                                                              style: GoogleFonts
                                                                  .sura(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        const Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 25,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                'lib/assets/image/PetPalace.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      'Tiêm ngừa nội kí sinh',
                                      style: GoogleFonts.sura(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 10),
                                  FutureBuilder<List<ListPetOwnerModel>>(
                                    future: controller.getPetOwnerList(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final List<ListPetOwnerModel>
                                            petOwnerList = snapshot.data!;

                                        final List<ListPetOwnerModel>
                                            matchingPetOwners =
                                            petOwnerList.where(
                                          (element) {
                                            print('Pet ID: ${pet.id}');
                                            return element.pet != null &&
                                                element.pet!.id == pet.id &&
                                                element.health != null &&
                                                element.health!.isNotEmpty;
                                          },
                                        ).toList();

                                        if (matchingPetOwners.isEmpty) {
                                          return const Center(
                                              child:
                                                  Text('Pet owner not found'));
                                        }

                                        final List<Map<String, dynamic>>
                                            filteredHealthDataList = [];

                                        for (final petOwner
                                            in matchingPetOwners) {
                                          for (final healthData
                                              in petOwner.health!) {
                                            if (healthData.type == 3) {
                                              filteredHealthDataList.add({
                                                'type': healthData.type,
                                                'data': json
                                                    .decode(healthData.data!),
                                              });
                                            }
                                          }
                                        }

                                        if (filteredHealthDataList.isEmpty) {
                                          return const Center(
                                              child: Text(
                                                  'Chưa có dữ liệu sức khỏe cho thú cưng này  '));
                                        }

                                        return Column(
                                          children: filteredHealthDataList
                                              .map((healthData) {
                                            final Map<String, dynamic> data =
                                                healthData['data'];

                                            return Card(
                                              color: Colors.white,
                                              margin: const EdgeInsets.all(10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: const BorderSide(
                                                  color: Color(0xFF12609F),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .calendar_month_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 28,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  data[
                                                                      "Ngày tiêm"],
                                                                  style:
                                                                      GoogleFonts
                                                                          .sura(
                                                                    color: Colors
                                                                        .black,
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Bệnh: ${data["Bệnh"]}',
                                                              style: GoogleFonts
                                                                  .sura(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Thuốc: ${data["Thuốc"]}',
                                                              style: GoogleFonts
                                                                  .sura(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        const Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 25,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                'lib/assets/image/PetPalace.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      'Tiêm ngừa ngoại kí sinh',
                                      style: GoogleFonts.sura(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 10),
                                  FutureBuilder<List<ListPetOwnerModel>>(
                                    future: controller.getPetOwnerList(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final List<ListPetOwnerModel>
                                            petOwnerList = snapshot.data!;

                                        final List<ListPetOwnerModel>
                                            matchingPetOwners =
                                            petOwnerList.where(
                                          (element) {
                                            print('Pet ID: ${pet.id}');
                                            return element.pet != null &&
                                                element.pet!.id == pet.id &&
                                                element.health != null &&
                                                element.health!.isNotEmpty;
                                          },
                                        ).toList();

                                        if (matchingPetOwners.isEmpty) {
                                          return const Center(
                                              child:
                                                  Text('Pet owner not found'));
                                        }

                                        final List<Map<String, dynamic>>
                                            filteredHealthDataList = [];

                                        for (final petOwner
                                            in matchingPetOwners) {
                                          for (final healthData
                                              in petOwner.health!) {
                                            if (healthData.type == 2) {
                                              filteredHealthDataList.add({
                                                'type': healthData.type,
                                                'data': json
                                                    .decode(healthData.data!),
                                              });
                                            }
                                          }
                                        }

                                        if (filteredHealthDataList.isEmpty) {
                                          return const Center(
                                              child: Text(
                                                  'Chưa có dữ liệu sức khỏe cho thú cưng này'));
                                        }

                                        return Column(
                                          children: filteredHealthDataList
                                              .map((healthData) {
                                            final Map<String, dynamic> data =
                                                healthData['data'];

                                            return Card(
                                              color: Colors.white,
                                              margin: const EdgeInsets.all(10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: const BorderSide(
                                                  color: Color(0xFF12609F),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .calendar_month_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 28,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  data[
                                                                      "Ngày tiêm"],
                                                                  style:
                                                                      GoogleFonts
                                                                          .sura(
                                                                    color: Colors
                                                                        .black,
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Bệnh: ${data["Bệnh"]}',
                                                              style: GoogleFonts
                                                                  .sura(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Thuốc: ${data["Thuốc"]}',
                                                              style: GoogleFonts
                                                                  .sura(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        const Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 25,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                'lib/assets/image/PetPalace.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      'Điều trị và phẩu thuật',
                                      style: GoogleFonts.sura(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 10),
                                  FutureBuilder<List<ListPetOwnerModel>>(
                                    future: controller.getPetOwnerList(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final List<ListPetOwnerModel>
                                            petOwnerList = snapshot.data!;

                                        final List<ListPetOwnerModel>
                                            matchingPetOwners =
                                            petOwnerList.where(
                                          (element) {
                                            print('Pet ID: ${pet.id}');
                                            return element.pet != null &&
                                                element.pet!.id == pet.id &&
                                                element.health != null &&
                                                element.health!.isNotEmpty;
                                          },
                                        ).toList();

                                        if (matchingPetOwners.isEmpty) {
                                          return const Center(
                                              child:
                                                  Text('Pet owner not found'));
                                        }

                                        final List<Map<String, dynamic>>
                                            filteredHealthDataList = [];

                                        for (final petOwner
                                            in matchingPetOwners) {
                                          for (final healthData
                                              in petOwner.health!) {
                                            if (healthData.type == 4) {
                                              filteredHealthDataList.add({
                                                'type': healthData.type,
                                                'data': json
                                                    .decode(healthData.data!),
                                              });
                                            }
                                          }
                                        }

                                        if (filteredHealthDataList.isEmpty) {
                                          return const Center(
                                              child: Text(
                                                  'Chưa có dữ liệu sức khỏe cho thú cưng này'));
                                        }

                                        return Column(
                                          children: filteredHealthDataList
                                              .map((healthData) {
                                            final Map<String, dynamic> data =
                                                healthData['data'];

                                            return Card(
                                              color: Colors.white,
                                              margin: const EdgeInsets.all(10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: const BorderSide(
                                                  color: Color(0xFF12609F),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .calendar_month_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 28,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  data["Ngày"],
                                                                  style:
                                                                      GoogleFonts
                                                                          .sura(
                                                                    color: Colors
                                                                        .black,
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Chấn đoán BS: ${data["Nội dung"]}',
                                                              style: GoogleFonts
                                                                  .sura(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        const Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 30,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                'lib/assets/image/PetPalace.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  String calculateAge(String birthDate) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime now = DateTime.now();
    final DateTime birthday = formatter.parse(birthDate);

    int years = now.year - birthday.year;
    int months = now.month - birthday.month;
    int days = now.day - birthday.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years -= 1;
      months += 12;
    }

    final String ageYears = years > 0 ? '$years tuổi ' : '';
    final String ageMonths = months > 0 ? '$months tháng' : '';

    if (years > 0 && months > 0) {
      return '$ageYears$ageMonths';
    } else if (years > 0) {
      return ageYears;
    } else {
      return ageMonths;
    }
  }
}

extension DateTimeExtensions on DateTime {
  String get weekdayName {
    switch (weekday) {
      case 1:
        return 'Thứ hai';
      case 2:
        return 'Thứ ba';
      case 3:
        return 'Thứ tư';
      case 4:
        return 'Thứ năm';
      case 5:
        return 'Thứ sáu';
      case 6:
        return 'Thứ bảy';
      case 7:
        return 'Chủ nhật';
      default:
        return '';
    }
  }
}
