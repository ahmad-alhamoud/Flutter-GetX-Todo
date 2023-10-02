import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifyPage extends StatelessWidget {
  final String? label;
  NotifyPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Get.isDarkMode ? Colors.white : Colors.grey),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          label.toString().split('|')[0],
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Center(
        child: Container(
          height: 400 ,
          width: 300 ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode ? Colors.white : Colors.grey[400]
          ),
          child: Text(
            label.toString().split('|')[1],
            style: TextStyle(
                color: Get.isDarkMode ? Colors.black : Colors.white ,
              fontSize: 30
            ),
          ),
        ),
      ),
    );
  }
}
