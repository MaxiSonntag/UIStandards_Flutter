import 'package:flutter/material.dart';

class InfoComponent extends StatelessWidget{

  final int entry;

  InfoComponent(this.entry);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("This is info about list entry $entry", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
    );
  }
}