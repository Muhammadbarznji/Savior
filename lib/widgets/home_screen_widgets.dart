import 'package:flutter/material.dart';


class CardButton extends StatelessWidget {
  var  imagepath ,height, width;
  CardButton(
      {this.imagepath,
        this.height,
        this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: imagepath,
    );
  }
}