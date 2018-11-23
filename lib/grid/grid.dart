import 'package:flutter/material.dart';

class Grid extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new GridView.extent(
      maxCrossAxisExtent: MediaQuery.of(context).size.width/4,
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 3.0,
      children: List<Container>.generate(26, (index){
        return new Container(
          child: new Image.asset('sample_images/DSC_$index.jpg', fit: BoxFit.cover ,),
        );
      }),
    );
  }
}