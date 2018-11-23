import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_standards_flutter/charts/chart_page.dart';
import 'package:ui_standards_flutter/grid/grid.dart';

class GridPage extends StatefulWidget {
  @override
  State createState() => new GridState();
}

class GridState extends State<GridPage> {

  _showCharts(){
    Navigator.push(context, new MaterialPageRoute(builder: (context)=>new ChartPage()));
  }

  @override
  Widget build(BuildContext context) {
    Widget _getPlatformPageBody() {
      if (Theme.of(context).platform == TargetPlatform.android) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('ImagesPage'),
            actions: <Widget>[
              new IconButton(icon: Icon(Icons.show_chart), onPressed: _showCharts)
            ],
          ),
          body: new Grid(),
        );
      }

      return new CupertinoPageScaffold(
          child: new Material(
        child: new CustomScrollView(
          slivers: <Widget>[
            new CupertinoSliverNavigationBar(
              largeTitle: new Text("ImagesPage"),
            trailing: new IconButton(icon: Icon(Icons.show_chart), onPressed: _showCharts),
            ),
            new SliverGrid.extent(
              maxCrossAxisExtent: 150.0,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
              children: List<Container>.generate(26, (index) {
                return new Container(
                  child: new Image.asset(
                    'sample_images/DSC_$index.jpg',
                    fit: BoxFit.cover,
                  ),
                );
              }),
            )
          ],
        ),
      ));
    }

    return _getPlatformPageBody();
  }
}
