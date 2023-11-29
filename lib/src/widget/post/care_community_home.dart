import 'package:app_pet_care/src/controller/care_community/comment_controller.dart';
import 'package:app_pet_care/src/controller/care_community/comment_list_controller.dart';
import 'package:app_pet_care/src/controller/care_community/post_list_controller.dart';
import 'package:app_pet_care/src/controller/doctor_list_controller.dart';
import 'package:app_pet_care/src/model/doctor_model.dart';
import 'package:app_pet_care/src/widget/_common/bottom_bar_page.dart';
import 'package:app_pet_care/src/widget/_common/trend.dart';
import 'package:app_pet_care/src/widget/post/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PagesSceen extends StatelessWidget {
  const PagesSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostListController());

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'PetPalace',
          style: GoogleFonts.originalSurfer(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
          ),
        ),
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(PostScreen()
              )?.then((value) {
                if (value != null && value['isReload'] == true) {
                   controller.onInit();
                }
              });
            },
            icon: const Icon(
              Icons.add_a_photo_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FrameTrend(),
            const Divider(
              height: 1.5,
              color: Colors.grey,
            ),
            Obx(
              () {
                if (controller.isLoading.value) {
                  return CircularProgressIndicator();
                } else if (controller.isFailedLoading.value) {
                  return Text('Failed to load posts');
                } else {
                  return SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: controller.list.map((post) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 55,
                                      height: 55,
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  post.user?.avatar?.url ?? '',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.user?.name ?? '',
                                          style: GoogleFonts.sura(
                                            textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          calculateTimeDifference(
                                              post.createdDate ?? ''),
                                          style: GoogleFonts.sura(
                                            textStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.more_horiz_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Image.network(
                                  post.avatar?.url ?? '',
                                  height: 210,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        final postId = post.id ?? '';
                                        controller.updateReactPost(postId);
                                        post.react = post.react == 0 ? 1 : 0;
                                      },
                                      icon: Icon(
                                        // Icons.favorite_border_outlined,
                                        post.react == 1
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        //
                                        color: post.react == 1
                                            ? Colors.red
                                            : Colors.black,
                                      
                                        size: 28,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        print('Post ID: ${post.id}');
                                        _showComment(context,
                                            postId: post.id ?? '');
                                      },
                                      icon: const Icon(
                                        Icons.chat_bubble_outline,
                                        color: Colors.black,
                                        size: 28,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.label_outline,
                                        color: Colors.black,
                                        size: 28,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.bookmark_border_outlined,
                                        color: Colors.black,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: post.user?.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' ${post.content}',
                                              style: const TextStyle(
                                                fontSize: 19,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ));
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    ));
  }
}

void _showComment(BuildContext context, {required String postId}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      final userListController = Get.put(DoctorListController());
      final commentController = Get.put(CommentController());
      final controllerComment = Get.put<CommentListController>(
        CommentListController(postId: postId),
        tag: postId,
        permanent: false,
      );
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    'Bình luận',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sura(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1.5,
              color: Colors.grey,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FutureBuilder<List<DoctorModel>>(
                            future: userListController.fetchUserList(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text('Lỗi: ${snapshot.error}');
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                final user = snapshot.data![0];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            user.avatar?.link ?? ''),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return const Text('Không có dữ liệu');
                              }
                            }),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: commentController.commentTextController,
                        decoration: const InputDecoration(
                          hintText: 'Nhập bình luận...',
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        print('postId in _showComment: $postId');
                        commentController.createComment(postId: postId);
                      },
                      icon: const Icon(
                        Icons.send_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (controllerComment.isLoading.value) {
                return const CircularProgressIndicator();
              } else if (controllerComment.isFailedLoading.value) {
                return const Text('Failed to load comments');
              } else {
                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 15, bottom: 15),
                    child: Column(
                      children: [
                        if (controllerComment.list.isEmpty)
                          const Text(
                            'Chưa có bình luận nào.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          )
                        else
                          ...controllerComment.list.map((comment) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 45,
                                      height: 45,
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.blue,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    comment.user?.avatar?.url ??
                                                        ''),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                comment.user?.name ?? '',
                                                style: GoogleFonts.sura(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 19,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                calculateTimeDifference(
                                                    comment.createdDate ?? ''),
                                                style: GoogleFonts.sura(
                                                  textStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                comment.content ?? '',
                                                style: GoogleFonts.sura(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: Colors.black,
                                                  size: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      );
    },
  );
}

String calculateTimeDifference(String createdDate) {
  DateTime commentDate = DateTime.parse(createdDate);
  DateTime now = DateTime.now();
  Duration difference = now.difference(commentDate);

  if (difference.inDays > 0) {
    // return DateFormat('dd/MM/yyyy').format(commentDate);
    return '${difference.inDays} ngày trước';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} giờ trước';
  } else {
    return '${difference.inMinutes} phút trước';
  }
}
