import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
              InkWell(
                child: Text('texto'),
                onTap: _homeController.saveBank,
              ),
              GetX<HomeController>(
                initState: (_) {},
                builder: (_) {
                  try {
                   
                      return Container(
                    height: Get.height / 3,
                    child: ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(_.banks[index].name),
                      ),
                      itemCount: _.banks.length,
                    ),
                  );
                   
                  } catch (e) {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
