import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui_standards_flutter/enums.dart';

class InputPage extends StatefulWidget{

  @override
  State createState() {
    return InputState();
  }
}

class InputState extends State<InputPage>{

  var _autovalidate;
  var _formKey;
  var _validationText;
  TextStyle _validationTextStyle;

  TextEditingController _normalTextCtrl;
  TextEditingController _emailTextCtrl;
  TextEditingController _numberTextCtrl;
  TextEditingController _datePickerCtrl;
  TextEditingController _timePickerCtrl;



  @override
  void initState() {
    _initNewForm();
    super.initState();
  }

  _initNewForm(){
    _normalTextCtrl = TextEditingController();
    _emailTextCtrl = TextEditingController();
    _numberTextCtrl = TextEditingController();
    _datePickerCtrl = TextEditingController();
    _timePickerCtrl = TextEditingController();
    _validationTextStyle = _setValidationTextStyle(TextStyles.Neutral);
    _validationText = "Not validated yet";
    _autovalidate = false;
    _formKey = GlobalKey<FormState>();
  }

  TextStyle _setValidationTextStyle(TextStyles style){
    switch (style){
      case TextStyles.Success: return TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.green);
      case TextStyles.Failure: return TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.red);
      default: return TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.black);
    }
  }

  _dateTextFieldTapped() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 200));
    final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime(2050));
    if(date != null){
      _datePickerCtrl.text = date.toLocal().toString();

    }
  }

  _timeTextFieldTapped() async{
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(time != null){
      _timePickerCtrl.text = time.format(context).toString();
    }
  }

  @override
  Widget build(BuildContext context) {


    _validateForm(){
      if (_formKey.currentState.validate()){
        setState(() {
          _autovalidate = false;
          _validationText = "Everything alright!";
          _validationTextStyle = _setValidationTextStyle(TextStyles.Success);
        });

      }
      else{
        setState(() {
          _autovalidate = true;
          _validationText = "Something is wrong...Autovalidation started";
          _validationTextStyle = _setValidationTextStyle(TextStyles.Failure);
        });
      }
    }

    _resetForm(){
      setState(() {
        _initNewForm();
      });

    }

    String _validateEmail(String mail){
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(mail))
        return 'Enter Valid Email';
      else
        return null;
    }

    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
              autovalidate: _autovalidate,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //Text("Normal textfield", style: _headingStyle),
                  TextFormField(
                    controller: _normalTextCtrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Normal textfield"
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter some text';
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 18.0),),
                  //Text("E-Mail textfield", style: _headingStyle),
                  TextFormField(
                    controller: _emailTextCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "E-Mail textfield"
                    ),
                    validator: (value) {
                      return _validateEmail(value);
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 18.0),),
                  //Text("Phone number textfield", style: _headingStyle),
                  TextFormField(
                    controller: _numberTextCtrl,
                    decoration: InputDecoration(
                        labelText: "Phone number textfield"
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value.length != 10) {
                        return "Mobile Number must be of 10 digit";
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 25.0),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                      child: GestureDetector(
                          onTap: _dateTextFieldTapped,
                          child: Container(
                            color: Colors.transparent,
                            child: IgnorePointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Date"
                                ),
                                controller: _datePickerCtrl,
                                validator: (value){
                                  if(value.isEmpty){
                                    return "Pick valid date";
                                  }
                                },
                              ),
                            ),
                          )
                      ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                            onTap: _timeTextFieldTapped,
                            child: Container(
                              color: Colors.transparent,
                              child: IgnorePointer(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Time"
                                  ),
                                  controller: _timePickerCtrl,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "Pick time";
                                    }
                                  },
                                ),
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 25.0),),
                  Text(_validationText, style: _validationTextStyle,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: RaisedButton(
                          child: Text("Validate"),
                          color: Theme.of(context).accentColor,
                          onPressed: _validateForm,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 2,
                        child: RaisedButton(
                          child: Text("Reset"),
                            color: Theme.of(context).accentColor,
                            onPressed: _resetForm
                        ),
                      )
                    ],
                  )

                ],
              )
          )
      ),
    );
  }
}