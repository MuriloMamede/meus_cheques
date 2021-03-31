import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:meuscheques/app/modules/home/views/widgets/account_list.dart';

class HomePage extends GetView<HomeController> {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    void openAccountLister() {
      showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.sizeFade,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AccountList();
        },
      );
    }

    return Scaffold(
      // drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Meus Cheques'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: PopupMenuButton<String>(
              onSelected: (String s) {
                if (s == 'editRota') {
                } else if (s == 'deleteRota') {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        actions: [
                          FlatButton(
                            child: Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          FlatButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("Excluir",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                        title: Text(
                          'Excluir dados',
                          textAlign: TextAlign.start,
                          style: TextStyle(),
                        ),
                        content: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.warning),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Essa ação é irreversível!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              //onSelected: _select,
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                    value: 'editRota',
                    child: Text(
                      'Editar',
                      textAlign: TextAlign.left,
                    )),
                PopupMenuItem<String>(
                    value: 'deleteRota',
                    child: Text(
                      'Apagar',
                      textAlign: TextAlign.left,
                    )),
              ],
            ),
          ),
          IconButton(
              icon: Icon(
                CommunityMaterialIcons.bank,
                color: Colors.white,
              ),
              onPressed: openAccountLister)
        ],
      ),
      //bottomNavigationBar: CustomBottomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              InkWell(
                child: Container(
                    color: Colors.amber,
                    height: 50,
                    width: 30,
                    child: Text('texto')),
                onTap: _homeController.saveAccount,
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
