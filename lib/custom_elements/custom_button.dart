import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget{

  final Text child;
  final VoidCallback onTap;


  CustomButton({this.child, this.onTap});

  @override
  State createState() {
    return CustomButtonState();
  }
}

class CustomButtonState extends State<CustomButton>{

  var isKeyDown = false;


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details){
        setState(() {
          isKeyDown = true;
        });
      },
        onTapUp: (details){
        setState(() {
          isKeyDown = false;
        });
        },
      child: Material(
        elevation: _getElevation(),
        child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(20.0), left: Radius.circular(3.0)),
            ),
            child: widget.child
        ),
      )
    );
  }

  double _getElevation(){
    if(this.isKeyDown){
      return 1.0;
    }
    return 5.0;
  }
}