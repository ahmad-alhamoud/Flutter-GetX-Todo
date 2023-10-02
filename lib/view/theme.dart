import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';



const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {

 static final  light =  ThemeData(
   backgroundColor: Colors.white ,
  primaryColor : primaryClr ,
  brightness: Brightness.light,
  )  ;

 static final  dark =  ThemeData(
   backgroundColor: darkGreyClr ,
  primaryColor: darkGreyClr ,
  brightness: Brightness.dark  ,
  ) ;

}

TextStyle get subHeadingStyle{
  return
    TextStyle(
      color: Get.isDarkMode ? Colors.grey[400]: Colors.grey ,
      fontSize: 24,
      fontWeight:  FontWeight.bold ,

  ) ;
}

TextStyle get headingStyle{
  return
  TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black ,
      fontSize: 30,
      fontWeight:  FontWeight.bold ,

  ) ;
}
TextStyle get titleStyle {
  return
    TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black ,
      fontSize: 16 ,
      fontWeight:  FontWeight.bold ,

  ) ;
}
TextStyle get subTitleStyle {
  return TextStyle(
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600] ,
      fontSize: 14 ,
      fontWeight:  FontWeight.w400 ,

  ) ;
}

TextStyle get bodyStyle {
  return TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black ,
      fontSize: 14,
      fontWeight:  FontWeight.w400 ,

  ) ;
}
TextStyle get body2Style {
  return TextStyle(
      color: Get.isDarkMode ? Colors.grey[200] : Colors.black ,
      fontSize: 14 ,
      fontWeight:  FontWeight.bold ,

  ) ;
}
