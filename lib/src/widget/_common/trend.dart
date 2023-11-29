import 'package:app_pet_care/src/widget/_common/frame_new.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrameTrend extends StatelessWidget {
  const FrameTrend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      height: 275,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.merge_type_outlined,
                color: Colors.grey,
              ),
              Text(
                'Xu hướng nổi bật',
                style: GoogleFonts.sura(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CarouselSlider(
            items: [
              NewFrame(
                text: 'Các dịch vụ nổi bật của\n PetPalace',
                image: "lib/assets/image/ban6.png",
                onTap: () {},
              ),
              NewFrame(
                text: '5 cách chăm sóc thú cưng mùa \nhè',
                image: "lib/assets/image/ban7.png",
                onTap: () {},
              ),
              NewFrame(
                text: 'Đặt lịch ngay với chúng tôi!!',
                image: "lib/assets/image/ban8.png",
                onTap: () {},
              ),
            ],
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: false,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration:
                  const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}