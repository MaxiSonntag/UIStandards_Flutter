import 'package:flutter/material.dart';
import 'package:ui_standards_flutter/enums.dart';

class CustomCalendarElement extends StatelessWidget{

  final DateTime date;
  final bool selected;

  TextStyle _weekdayStyle;
  TextStyle _dayStyle;
  TextStyle _selectedDayStyle;


  CustomCalendarElement({@required this.date, @required this.selected});


  @override
  Widget build(BuildContext context) {

    _weekdayStyle = TextStyle(fontSize: 10.0, color: Theme.of(context).accentColor);
    _dayStyle = TextStyle(fontSize: 20.0, color: Theme.of(context).accentColor);
    _selectedDayStyle = TextStyle(fontSize: 20.0, color: Theme.of(context).primaryColorDark);

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: MediaQuery.of(context).size.width / 7,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Text("${weekdays[(date.weekday - 1)][0]}", style: _weekdayStyle,),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 10,
                height: MediaQuery.of(context).size.width / 10,
                decoration: _getSelectionDecoration(),
                child: Center(
                  child: Text("${date.day}", style: selected ? _selectedDayStyle : _dayStyle),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  BoxDecoration _getSelectionDecoration() {
    if (selected) {
      final selectionColor = Colors.white;
      return BoxDecoration(
        shape: BoxShape.circle,
        color: selectionColor,
      );
    }
    return null;
  }
}