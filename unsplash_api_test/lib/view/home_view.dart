import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:unsplash_api_test/controllers/app_controller.dart';
import 'package:unsplash_api_test/view/detail_view.dart';
import 'package:unsplash_api_test/widget/app_bar.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final AppController homeController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            /// AppBar
            const MyAppBar(),

            /// Main Body
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),

                  /// TapBar
                  Expanded(flex: 1, child: _buildTabBar()),
                  const SizedBox(
                    height: 25,
                  ),

                  /// Pictures
                  Expanded(
                    flex: 13,
                    child: Obx(
                      () => homeController.isLoading.value
                          ? Center(
                              child: LoadingAnimationWidget.flickr(
                                rightDotColor: Colors.black,
                                leftDotColor: const Color(0xfffd0079),
                                size: 30,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GridView.custom(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate: SliverQuiltedGridDelegate(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  repeatPattern:
                                      QuiltedGridRepeatPattern.inverted,
                                  pattern: const [
                                    QuiltedGridTile(2, 2),
                                    QuiltedGridTile(1, 1),
                                    QuiltedGridTile(1, 1),
                                    QuiltedGridTile(1, 2),
                                  ],
                                ),
                                childrenDelegate: SliverChildBuilderDelegate(
                                    childCount: homeController.photos.length,
                                    (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) =>
                                              DetailsView(index: index),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: homeController.photos[index].id!,
                                      child: Container(
                                        margin: const EdgeInsets.all(2),
                                        child: CachedNetworkImage(
                                          imageUrl: homeController
                                              .photos[index].urls!['small']!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const CupertinoActivityIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.image_not_supported_rounded,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom TabBar
  Widget _buildTabBar() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeController.orders.length,
        itemBuilder: (ctx, i) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                homeController.selectedIndex.value = i;
                homeController.ordersFunc(homeController.orders[i]);
              },
              child: AnimatedContainer(
                  margin: EdgeInsets.fromLTRB(i == 0 ? 15 : 5, 0, 5, 0),
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                        i == homeController.selectedIndex.value ? 15 : 9)),
                    color: i == homeController.selectedIndex.value
                        ? const Color.fromARGB(255, 216, 1, 105)
                        : Colors.grey[200],
                  ),
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Text(
                      homeController.orders[i],
                      style: GoogleFonts.ubuntu(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: i == homeController.selectedIndex.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )),
            ),
          );
        });
  }
}
