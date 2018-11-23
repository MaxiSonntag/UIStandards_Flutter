import "package:flutter/material.dart";

class ThemePage extends StatefulWidget{

  @override
  State createState() {
    return ThemeState();
  }
}

class ThemeState extends State<ThemePage> with TickerProviderStateMixin{

  AnimationController _animationCtrl;
  final _headingStyle = TextStyle(fontWeight: FontWeight.bold);
  final _textAlignment = TextAlign.center;
  var _selectedDrawerItem = 0;
  var _checked = true;
  var _sliderValue = 0.5;


  @override
  void initState() {
    super.initState();
    _animationCtrl = AnimationController(vsync: this, lowerBound: 0.0, upperBound: 1.0, duration: Duration(seconds: 2));
    _animationCtrl.addListener((){

      setState(() {});

    });
  }

  _startAnimation(){
    if(_animationCtrl.value == 0.0){
      _animationCtrl.forward(from: 0.0);
    }
    else{
      _animationCtrl.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: ThemeData.lerp(ThemeData.light(), ThemeData.dark(), _animationCtrl.value),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text("Change Theme"),
              onPressed: (){_startAnimation();},
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(2.0),
              height: MediaQuery.of(context).size.height*0.75,
              color: Colors.black,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Changing themes"),
                  actions: <Widget>[
                    IconButton(onPressed: (){}, icon: Icon(Icons.color_lens),)
                  ],
                  bottom: TabBar(tabs: [
                    Tab(text: "Tab 1",),
                    Tab(text: "Tab 2",),
                    Tab(text: "Tab 3",)
                  ],
                    controller: TabController(length: 3, vsync: this),
                  ),
                ),
                drawer: _getSampleDrawer(),
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: <Widget>[
                        _getFirstRow(),
                        Divider(),
                        _getSecondRow(),
                        Divider(),
                        _getThirdRow(),
                        Divider(),
                        _getFourthRow()
                      ],
                    ),
                  )
                )
              ),
            ),

          ],
        ),
      )
    );
  }

  Drawer _getSampleDrawer(){
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: Center(
                child: CircleAvatar(
                  child: Text("B", style: TextStyle(fontSize: 20.0),),
                  minRadius: 30.0,
                  maxRadius: 60.0,
                ),
              )
          ),
          ListTile(
            selected: 0==_selectedDrawerItem,
            onTap: (){setState(() {
              _selectedDrawerItem = 0;
            });},
            title: Text("Sample item"),
            leading: Icon(Icons.phone),
          ),
          ListTile(
            selected: 1==_selectedDrawerItem,
            onTap: (){setState(() {
              _selectedDrawerItem = 1;
            });},
            title: Text("Sample item 2"),
            leading: Icon(Icons.person),
          ),
          AboutListTile(
            icon: Icon(Icons.info_outline),
          )
        ],
      ),
    );
  }

  Row _getFirstRow(){
    return Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Text("FAB", style: _headingStyle, textAlign: _textAlignment),
                FloatingActionButton(
                  onPressed: null,
                  child: Text("+"),
                ),
              ],
            )
        ),
        Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Text("Avatar", style: _headingStyle, textAlign: _textAlignment),
                CircleAvatar(
                  child: Text("T"),
                  minRadius: 30.0,
                ),
              ],
            )
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Text("RaisedButton", style: _headingStyle, textAlign: _textAlignment,),
              RaisedButton(child: Text("Useless"), onPressed: (){},)
            ],
          ),
        )
      ],
    );

  }

  Column _getSecondRow(){
    final _editingCtrl = TextEditingController();
    _editingCtrl.text = "Sample textfield";
    return Column(
      children: <Widget>[
        TextField(controller: _editingCtrl,)
      ],
    );
  }

  Row _getThirdRow(){
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Checkbox(value: _checked, onChanged: (val){setState(() {
            _checked = !_checked;
          });},),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Switch(value: _checked, onChanged: (val){setState(() {
              _checked = !_checked;
            });}),
          )
        ),
      ],
    );
  }

  Row _getFourthRow(){
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Slider(value: _sliderValue,onChanged: (val){setState(() {
            _sliderValue = val;
          });},),
        ),
        Expanded(
          flex: 1,
          child: LinearProgressIndicator(value: null),
        )
      ],
    );
  }
}