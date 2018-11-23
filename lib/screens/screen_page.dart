import 'package:flutter/material.dart';
import 'mobile_layout.dart';
import 'tablet_layout.dart';

class ScreenPage extends StatefulWidget{

  @override
  State createState() {
    return ScreenState();
  }
}

class ScreenState extends State<ScreenPage>{
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      final shortest = constraints.smallest.shortestSide;
      if(shortest < 600){
        return MobileLayout();
      }
      else{
        return TabletLayout();
      }
    }
    );
  }
}