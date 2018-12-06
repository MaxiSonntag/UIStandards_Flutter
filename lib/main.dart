import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_standards_flutter/charts/chart_page.dart';
import 'package:ui_standards_flutter/contacts/contact_data.dart';
import 'package:ui_standards_flutter/contacts/contact.dart';
import 'package:ui_standards_flutter/contacts/contact_list.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ui_standards_flutter/details/detail_page.dart';
import 'package:ui_standards_flutter/edit/edit_page.dart';
import 'package:ui_standards_flutter/grid/grid.dart';
import 'package:ui_standards_flutter/images/images_page.dart';
import 'package:ui_standards_flutter/inputs/inputs_page.dart';
import 'package:ui_standards_flutter/map/map_page.dart';
import 'package:ui_standards_flutter/tabs/tabs_page.dart';
import 'package:ui_standards_flutter/themes/theme_page.dart';
import 'package:ui_standards_flutter/screens/screen_page.dart';
import 'package:ui_standards_flutter/web/web_content_page.dart';
import 'custom_elements/custom_elements_page.dart';
import 'enums.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() {
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> with SingleTickerProviderStateMixin {
  List<Contact> _contacts = List<Contact>();
  var _selectedDrawerItem = DrawerItems.List;
  var _appBarTitle = "List Master-Detail";

  @override
  void initState() {
    super.initState();
    /*var initializationSettingsAndroid =
    new AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        selectNotification: onSelectNotification);*/
  }



  @override
  Widget build(BuildContext context) {
    _contacts.addAll(kContacts);

    //Uncomment for 50000 list entries
    /*for (var i = 12; i < 50000; i++) {
      _contacts.add(
          Contact(fullName: "Filler", email: "FillerMail@something", id: "$i"));
    }*/

    _tappedNavigationItem(DrawerItems item) {


      if(item == DrawerItems.ScreenSizes){
        Navigator.push(context, MaterialPageRoute(builder: (context){return ScreenPage();}));
        return;
      }
      else if(item == DrawerItems.CustomElements){
        Navigator.push(context, MaterialPageRoute(builder: (context){return CustomElementsPage();}));
        return;
      }

      setState(() {
        _selectedDrawerItem = item;
        _appBarTitle = _getAppBarTitleForItem(item);
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
        ),
        bottomNavigationBar: null,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  child: new Center(
                    child: new CircleAvatar(
                      child: new Text("ME"),
                      maxRadius: 100.0,
                    ),
                  )
              ),
              ListTile(
                selected: DrawerItems.List == _selectedDrawerItem,
                leading: Icon(Icons.list),
                title: Text("List Master-Detail"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.List);
                },
              ),
              ListTile(
                selected: DrawerItems.Grid == _selectedDrawerItem,
                leading: Icon(Icons.grid_on),
                title: Text("Grid"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.Grid);
                },
              ),
              ListTile(
                selected: DrawerItems.Tabs == _selectedDrawerItem,
                leading: Icon(Icons.tab),
                title: Text("Tabs"),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TabsPage()));
                },
              ),
              ListTile(
                selected: DrawerItems.Images == _selectedDrawerItem,
                leading: Icon(Icons.image),
                title: Text("Images"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.Images);
                },
              ),
              ListTile(
                selected: DrawerItems.Charts == _selectedDrawerItem,
                leading: Icon(Icons.show_chart),
                title: Text("Charts"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.Charts);
                },
              ),
              ListTile(
                selected: DrawerItems.Input == _selectedDrawerItem,
                leading: Icon(Icons.input),
                title: Text("Inputs"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.Input);
                },
              ),
              ListTile(
                selected: DrawerItems.Themes == _selectedDrawerItem,
                leading: Icon(Icons.collections),
                title: Text("Themes"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.Themes);
                },
              ),
              ListTile(
                selected: DrawerItems.ScreenSizes == _selectedDrawerItem,
                leading: Icon(Icons.photo_size_select_large),
                title: Text("Screen sizes"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.ScreenSizes);
                },
              ),
              ListTile(
                selected: DrawerItems.CustomElements == _selectedDrawerItem,
                leading: Icon(Icons.style),
                title: Text("Custom elements"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.CustomElements);
                },
              ),

              ListTile(
                selected: DrawerItems.WebContent == _selectedDrawerItem,
                leading: Icon(Icons.open_in_browser),
                title: Text("Web content"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.WebContent);
                },
              ),
              ListTile(
                selected: DrawerItems.Maps == _selectedDrawerItem,
                leading: Icon(Icons.map),
                title: Text("Maps"),
                onTap: (){
                  Navigator.pop(context);
                  _tappedNavigationItem(DrawerItems.Maps);
                },
              ),
            ],
          ),
        ),
        body: _getBody(),
    );
  }

  Widget _getBody(){
    switch (_selectedDrawerItem){
      case DrawerItems.List: return ContactList(_contacts);
      case DrawerItems.Grid: return Grid();
      case DrawerItems.Images: return ImagesPage();
      case DrawerItems.Charts: return ChartPage();
      case DrawerItems.Input: return InputPage();
      case DrawerItems.Themes: return ThemePage();
      case DrawerItems.ScreenSizes: return ScreenPage();
      case DrawerItems.CustomElements: return CustomElementsPage();
      case DrawerItems.WebContent: return WebContentPage();
      case DrawerItems.Maps: return MapPage();
      default: return new ContactList(_contacts);
    }
  }

  String _getAppBarTitleForItem(DrawerItems item){
    switch (item){
      case DrawerItems.List: return "List Master Detail";
      case DrawerItems.Grid: return "Grid";
      case DrawerItems.Images: return "Images";
      case DrawerItems.Charts: return "Charts";
      case DrawerItems.Input: return "Inputs";
      case DrawerItems.Themes: return "Themes";
      case DrawerItems.WebContent: return "WebContent";
      default: return "UI Standards";
    }
  }


  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new DetailPage(_contacts[0])),
    );
  }


  Future _showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }
}