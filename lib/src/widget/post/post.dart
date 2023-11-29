import 'dart:io';
import 'package:app_pet_care/src/controller/care_community/post_controller.dart';
import 'package:app_pet_care/src/controller/doctor_list_controller.dart';
import 'package:app_pet_care/src/model/doctor_model.dart';
import 'package:app_pet_care/src/model/image_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());
    final userListController = Get.put(DoctorListController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text(
            'Tạo bài viết',
            style: GoogleFonts.sura(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextButton(
                style: TextButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                  backgroundColor: const Color(0xFFFFE3D8),
                  minimumSize: const Size(40, 40),
                  foregroundColor: Colors.blue,
                ),
                onPressed: () {
                  controller.createPost();
                },
                child: const Text(
                  'Chia sẻ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<DoctorModel>>(
                  future: userListController.fetchUserList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: const CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Lỗi: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final user = snapshot.data![0];
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  NetworkImage(user.avatar?.link ?? ''),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              user.fullName ?? 'N/A',
                              style: GoogleFonts.sura(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text('Không có dữ liệu');
                    }
                  }),

              // PostImageWithOverlay(),
              Obx(() {
                if (postController.files.isNotEmpty) {
                  // Hiển thị dòng văn bản cho người dùng nhập
                  return Column(
                    children: [
                      Positioned(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: null,
                            controller: controller.contentPostController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              hintText: "Bạn đang nghĩ gì...?",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 220,
                        width: double.infinity,
                        child: Image.file(
                          File(postController.files[0].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                } else {
                  // Hiển thị PostImageWithOverlay khi không có hình ảnh được chọn
                  return PostImageWithOverlay();
                }
              }),

              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  _showImageSelection(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 50,
                      width: 165,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        color: const Color(0xFFFFE3D8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.image, color: Colors.blue),
                          const SizedBox(width: 10),
                          Text(
                            'Ảnh/Video',
                            style: GoogleFonts.sura(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PostImageWithOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "lib/assets/image/post.jpg",
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              style: GoogleFonts.sura(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              controller: postController.contentPostController,
              textAlign: TextAlign.center,
              maxLines: null,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                hintText: "Bạn đang nghĩ gì...?",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List<imageModel> files = [];
final PostController postController = Get.put(PostController());

getImageCamera() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    final imageTemp = imageModel(
      id: UniqueKey().toString(),
      filename: image.name,
      path: image.path,
    );
    postController.addImage(imageTemp);
  }
}

getImageGallery() async {
  try {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final imageTemp = imageModel(
        id: UniqueKey().toString(),
        filename: image.name,
        path: image.path,
      );
      postController.addImage(imageTemp);

      print('Đường dẫn hình ảnh: ${image.path}');
      print('Tên hình ảnh: ${image.name}');
      print('ID hình ảnh: ${imageTemp.id}');
      print('Files: ${postController.files}');
    } else {
      print('Không có hình ảnh nào đuợc chọn');
    }
  } catch (e) {
    print('Lỗi chọn hình ảnh: $e');
  }
}

void _showImageSelection(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Chọn Ảnh/Video',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: const Column(
                              children: [
                                Icon(
                                  Icons.photo_library,
                                  size: 30,
                                ),
                                SizedBox(height: 4),
                                Text('Thư viện ảnh',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            onTap: () {
                              getImageGallery();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Column(
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                SizedBox(height: 4),
                                Text('Camera',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            onTap: () {
                              getImageCamera();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
      });
}
