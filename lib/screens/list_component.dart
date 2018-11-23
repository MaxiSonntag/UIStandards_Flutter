import 'package:flutter/material.dart';

class ListComponent extends StatelessWidget{

  final selectedItem;
  final void Function(int) callback;

  ListComponent({@required this.callback, this.selectedItem});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (context, idx){
        return ListTile(
          title: Text("List entry $idx"),
          selected: selectedItem == idx,
          onTap: ()=>callback(idx),
        );
      },
    );
  }
}