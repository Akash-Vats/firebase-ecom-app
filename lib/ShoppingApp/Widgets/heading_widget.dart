import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubtitle;
  final String buttonText;
  final VoidCallback onTap;

  const HeadingWidget({super.key, required this.headingTitle, required this.headingSubtitle, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(headingTitle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        Text(headingSubtitle,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey),),
      ],),
        GestureDetector(onTap:onTap,
          child: Container(height:37,width:90,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.red,width: 1.5)),
            child: Center(child: Text(buttonText)) ,),
        )
    ],),) ;
  }
}
