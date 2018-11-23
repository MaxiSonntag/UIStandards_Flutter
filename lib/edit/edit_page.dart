import 'package:flutter/material.dart';
import 'package:ui_standards_flutter/contacts/contact.dart';
import 'package:flutter/cupertino.dart';

class EditPage extends StatefulWidget {
  Contact _contact;

  EditPage(this._contact);

  @override
  State createState() => new EditPageState(_contact);
}

class EditPageState extends State<EditPage> {
  final Contact _contact;

  EditPageState(this._contact);

  TextEditingController _nameTextCtrl;
  TextEditingController _emailTextCtrl;

  TextEditingController get nameTextCtrl => _nameTextCtrl;

  TextEditingController get emailTextCtrl => _emailTextCtrl;

  @override
  void initState() {
    _nameTextCtrl = new TextEditingController(text: _contact.fullName);
    _emailTextCtrl = new TextEditingController(text: _contact.email);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  var _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    _onSavePressed() {
      if (_formKey.currentState.validate()) {
        Map<String, String> newValues = {
          "name": nameTextCtrl.text,
          "email": emailTextCtrl.text
        };
        Navigator.pop(context, newValues);
      }else{
        setState(() {
          _autovalidate = true;
        });

      }
    }


    return new Material(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Edit"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.save, color: Colors.white,), onPressed: _onSavePressed)
          ],
        ),
        body: new Container(
            margin: EdgeInsets.all(15.0),
            child: new Form(
              autovalidate: _autovalidate,
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    new TextFormField(
                      controller: nameTextCtrl,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a name';
                        }
                      },
                    ),
                    new TextFormField(
                      controller: emailTextCtrl,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an email address';
                        }
                      },
                    )
                  ],
                )
            )
        ),
      ),
    );
  }
}
