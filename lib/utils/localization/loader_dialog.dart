import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'images_paths.dart';

void showLoader(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
            width: 140,
            height: 140,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade700,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImagesPaths.icDeliveryTruck,
                  height: 50,
                  width: 50,
                ),
                Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
                        child: const LinearProgressIndicator(
                            backgroundColor: Colors.green,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            minHeight: 3))
                    .w(90),
              ],
            ),
          ),
        );
      });
}

