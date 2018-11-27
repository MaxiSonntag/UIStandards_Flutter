import 'package:flutter/material.dart';
import 'package:ui_standards_flutter/custom_elements/calendar/custom_calendar_element.dart';
import 'package:ui_standards_flutter/custom_elements/calendar/custom_calendar.dart';
import 'custom_button.dart';

class CustomElementsPage extends StatefulWidget {
  DateTime selectedDate = DateTime.now();
  List<DateTime> items;
  int selectedItem = 0;

  @override
  State createState() {
    var startDate = DateTime.now().subtract(Duration(days: 50));
    items = List.generate(100, (index) {
      startDate = startDate.add(Duration(days: 1));
      return startDate;
    });
    selectedItem = items.indexOf(items.firstWhere((item) {
      return item.difference(DateTime.now()).abs() < Duration(seconds: 20);
    }));

    return CustomElementsPageState();
  }
}

class CustomElementsPageState extends State<CustomElementsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Custom calendar"),
          bottom: CustomCalendar(
            itemCount: widget.items.length,
            initialSelectionIndex: widget.selectedItem,
            builder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedItem = index;
                      widget.selectedDate = widget.items[index];
                    });
                  },
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.white),
                    child: CustomCalendarElement(
                      date: widget.items[index],
                      selected: widget.selectedItem == index,
                    ),
                  ));
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Center(
                child: Text("Information about sth at ${widget.selectedDate}"),
              ),
            ),
            Flexible(
                flex: 1,
                child: Center(
                  child: CustomButton(
                    child: Text("Custom Button", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2.0),),
                  )
                )
            )
          ],
        )
    );
  }
}
