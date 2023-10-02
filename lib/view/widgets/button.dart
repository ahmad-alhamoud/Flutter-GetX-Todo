import 'package:flutter/material.dart';

import 'package:todo/view/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  const MyButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(20) ,
            color: primaryClr

        ),
        width:120 ,
        height: 50,
        child: Text(label,style: const TextStyle(color:Colors.white, ),
          textAlign:TextAlign.center ,
        ),
      ),
    );
  }
}