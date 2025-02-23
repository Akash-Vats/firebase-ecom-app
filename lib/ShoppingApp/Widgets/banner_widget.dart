import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Controller/banner_controller.dart';

class BannerWidget extends StatelessWidget {
   BannerWidget({super.key});
final BannerController controller=Get.put(BannerController());
  @override
  Widget build(BuildContext context) {
    return Container(child:
      Obx((){
        return Column(children: [
          CarouselSlider(
            items: controller.bannerUrls
                .map(
                  (imageUrl) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 50,
                  ),
                ),
              ),
            )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              height: 200, // Fixed height
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              aspectRatio: 16 / 9, // Adjust aspect ratio to increase width
            ),

          ),

          const SizedBox(height: 10),
        ],);
      }),) ;
  }
}
