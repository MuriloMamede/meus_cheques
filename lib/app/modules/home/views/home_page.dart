import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/global/widgets/customBottomAppBar.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Cheques'),
      ),
      //bottomNavigationBar: CustomBottomAppBar(),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Text('texto'),
          ],
        )),
      ),
    );
  }
}
