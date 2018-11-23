import 'package:flutter/material.dart';
import 'list_component.dart';
import 'info_component.dart';

class TabletLayout extends StatefulWidget{


  @override
  State createState() {
    return TabletState();
  }
}

class TabletState extends State<TabletLayout>{

  var selectedEntry = 0;

  _itemTapped(int idx){
    setState(() {
      selectedEntry = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tablet layout"),
      ),
      body: OrientationBuilder(
          builder: (context, orientation){
            var flexFactor = 2;
            if(orientation == Orientation.landscape){
              flexFactor = 3;
            }
            return Row(children: <Widget>[
              Flexible(
                flex: 1,
                child: Material(
                  elevation: 4.0,
                  child: ListComponent(callback: _itemTapped, selectedItem: selectedEntry,),
                ),
              ),
              Flexible(
                flex: flexFactor,
                child: InfoComponent(selectedEntry),
              )
            ],
            );
          }
      ),
    );
  }
}