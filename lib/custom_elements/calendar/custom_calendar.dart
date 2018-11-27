import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget implements PreferredSizeWidget{

  final IndexedWidgetBuilder builder;
  final int itemCount;
  final int initialSelectionIndex;

  CustomCalendar({this.itemCount, this.builder, this.initialSelectionIndex});

  @override
  State createState() {
    return CustomCalendarState();
  }

  @override
  Size get preferredSize{
    return Size.fromHeight(60.0);
  }
}

class CustomCalendarState extends State<CustomCalendar>{

  ScrollController _scrollCtrl;




  @override
  Widget build(BuildContext context) {
    _scrollCtrl = ScrollController(initialScrollOffset: widget.initialSelectionIndex * (MediaQuery.of(context).size.width / 7));
    return Container(
      color: Theme.of(context).primaryColor,
      height: 60.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollCtrl,
          itemCount: widget.itemCount,
          itemBuilder: widget.builder
      ),
    );
  }
}