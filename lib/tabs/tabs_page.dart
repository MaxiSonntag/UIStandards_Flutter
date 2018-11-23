import "package:flutter/material.dart";

class TabsPage extends StatefulWidget{

  @override
  State createState() {
    return TabState();
  }
}

class TabState extends State<TabsPage> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(text: "Tab 1",),
            Tab(icon: Icon(Icons.center_focus_weak),),
            Tab(text: "Tab 3",),
          ]),
          title: Text("Tabs"),
        ),
        body: TabBarView(children: [
          Center(child: Text("This is Tab 1")),
          Center(child: Text("This is Tab 2 with icon")),
          Center(child: Text("This is Tab 3")),
        ]),
      ),
    );
  }
}