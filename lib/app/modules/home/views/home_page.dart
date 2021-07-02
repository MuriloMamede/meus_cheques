import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:meuscheques/app/modules/home/views/widgets/account_list.dart';
import 'package:meuscheques/app/modules/home/views/widgets/cheque_creator.dart';
import 'package:meuscheques/app/modules/home/views/widgets/cheque_listTile.dart';

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

    void openChequeCreator() {
      showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.sizeFade,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ChequeCreator();
        },
      );
    }

    return Scaffold(
      // drawer: NavDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: openChequeCreator,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Meus Cheques'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: PopupMenuButton<String>(
              onSelected: (String s) {
                if (s == 'editRota') {
                } else if (s == 'sair') {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        actions: [
                          FlatButton(
                            child: Text(
                              "Não",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          FlatButton(
                            color: Colors.red.shade100,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("Sim",
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                            onPressed: () {
                              _homeController.signOut();
                            },
                          ),
                        ],
                        title: Text(
                          'Deseja mesmo sair?',
                          textAlign: TextAlign.start,
                          style: TextStyle(),
                        ),
                        content: SizedBox(
                          height: 0,
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
                    value: 'sair',
                    child: Text(
                      'Sair',
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
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              GetX<HomeController>(
                initState: (_) {},
                builder: (_) {
                  try {
                    return Container(
                      height: Get.height / 3,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var cheque = _.cheques[index];
                          return ChequeListTile(cheque);
                        },
                        itemCount: _.cheques.length,
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
