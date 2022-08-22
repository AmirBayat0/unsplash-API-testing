import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/simple_ui+controller.dart';

class DetailView extends StatelessWidget {
  DetailView({required this.index});
  int index;

  SimpleUIController homeController = Get.find<SimpleUIController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Hero(
          tag: homeController.photos[index].id!,
          child: CachedNetworkImage(
            imageUrl: homeController.photos[index].urls!['regular']!,
            imageBuilder: (context, imageProvider) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Text(
                    homeController.photos[index].createdAt!
                        .substring(0, 10)
                        .replaceAll("-", " / "),
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
            placeholder: (context, url) => Center(
              child: LoadingAnimationWidget.flickr(
                rightDotColor: Colors.black,
                leftDotColor: const Color(0xfffd0079),
                size: 35,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_rounded,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
