import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'dart:convert';
import 'package:ui_standards_flutter/enums.dart';

class ChartPage extends StatefulWidget {
  @override
  State createState() {
    return ChartState();
  }
}

class ChartState extends State<ChartPage> {
  List<SampleUser> users = [];

  num _year;
  num _number;
  List<Series<UsersPerYear, String>> barChartData;
  List<Series<UsersPerYear, String>> pieChartData;

  @override
  void initState() {
    super.initState();
    _loadSampleData().then((createdUsers) {
      setState(() {
        users = createdUsers;
      });
      Future.wait([
        _createSampleData(ChartTypes.Bar),
        _createSampleData(ChartTypes.Pie)
      ]).then((returnValue) {
        setState(() {
          barChartData = returnValue[0];
          pieChartData = returnValue[1];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return users.length != 0 && barChartData != null && pieChartData != null
        ? _buildPageContent()
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _buildPageContent() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("Number of registered users per year",
                  style: TextStyle(fontSize: 25.0),
                  textAlign: TextAlign.center),
              //RaisedButton(child: Text("Load sample data"), onPressed: _loadSampleData,),
              Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: BarChart(
                    barChartData,
                    primaryMeasureAxis: NumericAxisSpec(
                        tickProviderSpec:
                            BasicNumericTickProviderSpec(desiredTickCount: 4)),
                    selectionModels: [
                      SelectionModelConfig(
                        type: SelectionModelType.info,
                        changedListener: _onSelectionChanged,
                      )
                    ],
                  )

                  //Uncomment for 40000 datapoints
                  //TimeSeriesChart(_createBigSampleData(), ),
                  ),
              Text("Year: $_year"),
              Text("Number: $_number"),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Number of registered users per year",
                    style: TextStyle(fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),
              Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: PieChart(pieChartData,
                      defaultRenderer: new ArcRendererConfig(
                          arcWidth: 60,
                          arcRendererDecorators: [new ArcLabelDecorator()]),
                      selectionModels: [
                        SelectionModelConfig(
                          type: SelectionModelType.info,
                          changedListener: _onSelectionChanged,
                        )
                      ])

                  //Uncomment for 40000 datapoints
                  //TimeSeriesChart(_createBigSampleData(), ),
                  )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<SampleUser>> _loadSampleData() async {
    if (users.isEmpty) {
      final jsonString = await DefaultAssetBundle.of(context)
          .loadString("sample_data/sample_json.json");
      final List<dynamic> data = jsonDecode(jsonString);
      List<Map<String, dynamic>> casted = data.cast();

      final List<SampleUser> temp = [];
      casted.forEach((user) => temp.add(_parseUser(user)));
      return temp;
    }
    return users;
  }

  SampleUser _parseUser(Map<String, dynamic> user) {
    final String name = user['name'];
    final int age = user['age'];
    final String registered = user['registered'];
    var dt = DateTime.parse(registered);
    return SampleUser(name, age, dt);
  }

  Future<List<Series<UsersPerYear, String>>> _createSampleData(
      ChartTypes type) async {
    HashMap<int, List<SampleUser>> mappedUsers = HashMap();

    for (int i = 0; i < users.length; i++) {
      final user = users[i];
      final year = user.registered.year;
      if (mappedUsers.containsKey(year)) {
        mappedUsers[year].add(user);
      } else {
        final List<SampleUser> newUserList = [user];
        mappedUsers.putIfAbsent(year, () => newUserList);
      }
    }

    List<UsersPerYear> data = [];
    mappedUsers.forEach((year, usersInYear) =>
        data.add(UsersPerYear(year, usersInYear.length - 1)));

    data.sort((user1, user2) => user1.year.compareTo(user2.year));

    return [
      new Series<UsersPerYear, String>(
        id: "Users",
        colorFn: (UsersPerYear usersPerYear, __) => type == ChartTypes.Bar
            ? _getColorForYear(3000)
            : _getColorForYear(usersPerYear.year),
        domainFn: (UsersPerYear usersPerYear, _) =>
            usersPerYear.year.toString(),
        measureFn: (UsersPerYear usersPerYear, _) => usersPerYear.number,
        labelAccessorFn: (UsersPerYear usersPerYear, _) =>
            '${usersPerYear.year}',
        data: data,
      )
    ];
  }

  // ignore: conflicting_dart_import
  Color _getColorForYear(int year) {
    switch (year) {
      case 2014:
        return MaterialPalette.deepOrange.shadeDefault;
      case 2015:
        return MaterialPalette.purple.shadeDefault;
      case 2016:
        return MaterialPalette.green.shadeDefault;
      case 2017:
        return MaterialPalette.gray.shadeDefault;
      default:
        return MaterialPalette.blue.shadeDefault;
    }
  }

  _onSelectionChanged(SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    num year;
    num numberOfUsers;

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      year = selectedDatum.first.datum.year;
      numberOfUsers = selectedDatum.first.datum.number;
    }

    // Request a build.
    setState(() {
      _year = year;
      _number = numberOfUsers;
    });
  }

  /// Create one series with sample hard coded data.
  List<Series<SampleUser, DateTime>> _createBigSampleData() {
    users.sort((user1, user2) => user1.registered.compareTo(user2.registered));

    final data = users;

    return [
      new Series<SampleUser, DateTime>(
        id: 'Users',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (SampleUser sampleUser, _) => sampleUser.registered,
        measureFn: (SampleUser sampleUser, _) => sampleUser.age,
        data: data,
      ),
      new Series<SampleUser, DateTime>(
        id: 'Ages',
        colorFn: (_, __) => MaterialPalette.red.shadeDefault,
        domainFn: (SampleUser sampleUser, _) => sampleUser.registered,
        measureFn: (SampleUser sampleUser, _) => sampleUser.age,
        data: data,
      ),
      new Series<SampleUser, DateTime>(
        id: 'Stuff',
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
        domainFn: (SampleUser sampleUser, _) => sampleUser.registered,
        measureFn: (SampleUser sampleUser, _) => sampleUser.age,
        data: data,
      ),
      new Series<SampleUser, DateTime>(
        id: 'Other',
        colorFn: (_, __) => MaterialPalette.deepOrange.shadeDefault,
        domainFn: (SampleUser sampleUser, _) => sampleUser.registered,
        measureFn: (SampleUser sampleUser, _) => sampleUser.age,
        data: data,
      )
    ];
  }
}

class SampleUser {
  final String name;
  final int age;
  final DateTime registered;

  SampleUser(this.name, this.age, this.registered);
}

class UsersPerYear {
  final int year;
  final int number;

  UsersPerYear(this.year, this.number);
}
