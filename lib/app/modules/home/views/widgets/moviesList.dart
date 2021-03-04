import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesListWidget extends StatelessWidget {
  @required
  final Function onTap;

  final String imageUrl;
  final String title;
  final String buttonText;
  final IconData icon;
  MoviesListWidget(
      {this.onTap, this.imageUrl, this.buttonText, this.icon, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
          height: Get.height * 0.25,
          width: Get.width * 0.3,
          child: Container(
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: Get.height * 0.04,
                    width: Get.width * 0.3,
                    color: Colors.red,
                    child:
                        Align(alignment: Alignment.center, child: Text(title)),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 7,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Get.theme.primaryColor,
                            Colors.red.shade200,
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              color: Colors.white,
                              size: 18,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 2, left: 2, right: 2),
                              child: Text(
                                buttonText,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //height: Get.height * 0.01,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(imageUrl)))),
    );
  }
}
