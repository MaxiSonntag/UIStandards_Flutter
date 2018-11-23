import 'dart:io';
import 'package:charts_flutter/flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImagesPicker extends StatefulWidget{

  @override
  State createState() {
    return _ImagesPickerState();
  }
}

class _ImagesPickerState extends State<ImagesPicker>{

  File _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Click to select local image", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: AspectRatio(aspectRatio: 16/9,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  child: _getLocalImage(),
                  flex: 8,
                ),
                Flexible(
                  child: Container(),
                  flex: 1,
                )
              ],
            ),
          )
        )
      ],
    );
  }

  Widget _getLocalImage(){
    return new GestureDetector(
      child: _getImage(),
      onTap: () => _startImagePicker(),
    );
  }

  Widget _getImage(){


      return new ClipRRect(
        borderRadius: new BorderRadius.circular(8.0),
        child: _image == null ? _getPlaceholder() : Image.file(_image, fit: BoxFit.cover,),
      );

  }

  _startImagePicker() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this._image = image;
    });
  }

  Widget _getPlaceholder(){
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text("Click me", style: TextStyle(fontSize: 30.0, color: Colors.white),textAlign: TextAlign.center,),
      ),
    );
  }
}