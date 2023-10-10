import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:unsplash_api_test/view/home_view.dart';

//
// Created by CodeWithFlexZ
// Tutorials on my YouTube
//
//! Instagram
//! @CodeWithFlexZ
//
//? GitHub
//? AmirBayat0
//
//* YouTube
//* Programming with FlexZ
//

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Unsplash Api Testing',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
