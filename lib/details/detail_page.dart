import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_standards_flutter/contacts/contact.dart';
import 'package:ui_standards_flutter/edit/edit_page.dart';

class DetailPage extends StatefulWidget {
  final Contact _contact;

  DetailPage(this._contact);

  @override
  State createState() => new DetailState(_contact);
}

class DetailState extends State<DetailPage> {
  Contact _contact;

  DetailState(this._contact);

  @override
  Widget build(BuildContext context) {
    _onEditPressed() async {
      var result = await Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new EditPage(_contact)));

      //Uncomment for custom page transition
      /*var result = await Navigator.push(
          context,
          new PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return EditPage(_contact);
              },
              transitionsBuilder: (context, animation1, animation2, child) {
                return new FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(animation1),
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 500)));*/

      var resMap = result as Map<String, String>;
      if (resMap != null) {
        var newContact = Contact(
            fullName: resMap['name'], email: resMap['email'], id: _contact.id);
        setState(() {
          _contact = newContact;
        });
      }
    }

    Future<bool> _onBackPressed() async {
      Map<String, String> newValues = {
        "name": _contact.fullName,
        "email": _contact.email
      };
      Navigator.pop(context, newValues);
      return new Future(() => false);
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Details"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: _onEditPressed)
        ],
      ),
      body: new WillPopScope(
          child: ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(15.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          minRadius: 50.0,
                          maxRadius: 80.0,
                          child: Text(
                            _contact.fullName[0],
                            style: TextStyle(fontSize: 50.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        _contact.fullName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 22.0),
                      ),
                      new Text(
                        _contact.email,
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      )
                    ],
                  ),
                  new Card(
                      margin: EdgeInsets.all(15.0),
                      child: new Container(
                        margin: EdgeInsets.all(10.0),
                        child: new Text(
                          'Here could be some \n awesome text and information about \n ${_contact.fullName}',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 25.0, color: Colors.black54),
                        ),
                      )),
                ],
              ),
            ],
          ),
          onWillPop: _onBackPressed),
    );
  }
}
