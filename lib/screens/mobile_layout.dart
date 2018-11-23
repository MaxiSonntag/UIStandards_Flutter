import 'package:flutter/material.dart';
import 'mobile_info_component.dart';
import 'list_component.dart';


class MobileLayout extends StatelessWidget{

  

  @override
  Widget build(BuildContext context) {

    _itemTapped(int idx){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MobileInfoComponent(idx)));
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile layout"),
      ),
      body: ListComponent(callback: _itemTapped,),
    );
  }
}