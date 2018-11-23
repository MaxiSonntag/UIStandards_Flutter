import 'package:flutter/material.dart';
import 'info_component.dart';

class MobileInfoComponent extends StatelessWidget{

  final int entry;

  MobileInfoComponent(this.entry);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile infos"),
      ),
      body: InfoComponent(this.entry),
    );
  }
}