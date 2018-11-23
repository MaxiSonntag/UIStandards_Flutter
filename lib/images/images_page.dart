import 'package:flutter/material.dart';
import 'package:ui_standards_flutter/images/items/images_inapp.dart';
import 'package:ui_standards_flutter/images/items/images_network.dart';
import 'package:ui_standards_flutter/images/items/images_picker.dart';

class ImagesPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Container(
            child: ImagesPicker(),
          ),
          Divider(),
          Container(
            child: ImagesInApp(),
          ),
          Divider(),
          Container(
            child: ImagesNetwork(),
          ),
        ],
      ),
    );
  }
}