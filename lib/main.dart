import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;
import 'package:mysql1/mysql1.dart';

var conn;
var listOfTeams = new List();
var listOfCoaches = new List();
var listOfContacts = new List();
var listOfSports = ["Cricket", "Football", "Basketball", "Handball"];
var fixturesTeamA = new List();
var fixturesTeamB = new List();
var fixturesResult = new List();
var fixturesDate = new List();
var fixturesSport = new List();
var standingTeam = new List();
var standingMatchPlayed = new List();
var standingWon = new List();
var standingLost = new List();
var standingDraws = new List();
var standingPoints = new List();
var standingGameName = new List();

void main() async {
//  listOfTeams.add("HELLO");
  conn = await MySqlConnection.connect(new ConnectionSettings(
      host: 'remotemysql.com',
      port: 3306,
      user: "zifqTD5Sgu",
      password: "3JmYgULTIa",
      db: "zifqTD5Sgu"));
  runApp(new MaterialApp(title: "Sports Portal", home: new Home()));
}

Future<bool> _fetchTeamDetails(context) async {
  var myQuery = "select team_name, coach_name, contact from Teams";
  var result;
  var foundException = 0;
  try {
    result = await conn.query(myQuery);
  } catch (e) {
    showError(e, context);
    foundException = 1;
  }
  if (foundException == 0) {
    listOfTeams.clear();
    listOfCoaches.clear();
    listOfContacts.clear();
    for (var i in result) listOfTeams.add(i[0]);
    for (var i in result) listOfCoaches.add(i[1]);
    for (var i in result) listOfContacts.add(i[2]);
    return true;
  }
  return false;
}

Future<bool> _fetchFixturesTeamWise(context, _currentItemSelected) async {
  var myQuery =
      "select date,teamA,teamB,result,sport_name from Fixtures where teamA = \"${_currentItemSelected}\" or teamB = \"${_currentItemSelected}\";";
  var result;
  var foundException = 0;
  try {
    result = await conn.query(myQuery);
  } catch (e) {
    showError(e, context);
    foundException = 1;
  }
  if (foundException == 0) {
    fixturesDate.clear();
    fixturesTeamA.clear();
    fixturesTeamB.clear();
    fixturesResult.clear();
    fixturesSport.clear();
    for (var i in result) fixturesDate.add(i[0].toString().substring(0, 10));
    for (var i in result) fixturesTeamA.add(i[1]);
    for (var i in result) fixturesTeamB.add(i[2]);
    for (var i in result) fixturesResult.add(i[3]);
    for (var i in result) fixturesSport.add(i[4]);
    for (var i in listOfTeams) debugPrint(i);
    return true;
  }
  return false;
}

Future<bool> _fetchFixturesSportWise(context, _currentItemSelected) async {
  var myQuery =
      "select date,teamA,teamB,result,sport_name from Fixtures where sport_name = \"${_currentItemSelected}\";";
  var result;
  var foundException = 0;
  try {
    result = await conn.query(myQuery);
  } catch (e) {
    showError(e, context);
    foundException = 1;
  }
  if (foundException == 0) {
    fixturesDate.clear();
    fixturesTeamA.clear();
    fixturesTeamB.clear();
    fixturesResult.clear();
    fixturesSport.clear();
    for (var i in result) fixturesDate.add(i[0].toString().substring(0, 10));
    for (var i in result) fixturesTeamA.add(i[1]);
    for (var i in result) fixturesTeamB.add(i[2]);
    for (var i in result) fixturesResult.add(i[3]);
    return true;
  }
  return false;
}

Future<bool> _fetchStandingsTeamWise(context, _currentItemSelected) async {
  var myQuery =
      "select team_name,matches_played,won,lost,draws,points,game_name from Standings where team_name = \"${_currentItemSelected}\" order by points desc;";
  var result;
  var foundException = 0;
  try {
    result = await conn.query(myQuery);
  } catch (e) {
    showError(e, context);
    foundException = 1;
  }
  if (foundException == 0) {
    standingTeam.clear();
    standingMatchPlayed.clear();
    standingWon.clear();
    standingLost.clear();
    standingDraws.clear();
    standingPoints.clear();
    standingGameName.clear();
    for (var i in result) standingTeam.add(i[0]);
    for (var i in result) standingMatchPlayed.add(i[1]);
    for (var i in result) standingWon.add(i[2]);
    for (var i in result) standingLost.add(i[3]);
    for (var i in result) standingDraws.add(i[4]);
    for (var i in result) standingPoints.add(i[5]);
    for (var i in result) standingGameName.add(i[6]);
    return true;
  }
  return false;
}

Future<bool> _fetchStandingsSportWise(context, _currentItemSelected) async {
  var myQuery =
      "select team_name,matches_played,won,lost,draws,points,game_name from Standings where game_name = \"${_currentItemSelected}\" order by points desc;";
  var result;
  var foundException = 0;
  try {
    result = await conn.query(myQuery);
  } catch (e) {
    showError(e, context);
    foundException = 1;
  }
  if (foundException == 0) {
    standingTeam.clear();
    standingMatchPlayed.clear();
    standingWon.clear();
    standingLost.clear();
    standingDraws.clear();
    standingPoints.clear();
    standingGameName.clear();
    for (var i in result) standingTeam.add(i[0]);
    for (var i in result) standingMatchPlayed.add(i[1]);
    for (var i in result) standingWon.add(i[2]);
    for (var i in result) standingLost.add(i[3]);
    for (var i in result) standingDraws.add(i[4]);
    for (var i in result) standingPoints.add(i[5]);
    for (var i in result) standingGameName.add(i[6]);
    return true;
  }
  return false;
}

//void exitConfirmation() {
//  showDialog(
//    builder: (BuildContext context) {
//      // return object of type Dialog
//      return AlertDialog(
//        backgroundColor: Colors.white,
//        title: new Text("Exit"),
//        content: new Text("Do you really want to exit?"),
//        actions: <Widget>[
//          // usually buttons at the bottom of the dialog
//          new FlatButton(
//            child: new Text("Yes"),
//            onPressed: () {
//              exit(0);
//            },
//          ),
//          new FlatButton(
//            child: new Text("No"),
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//          ),
//        ],
//      );
//    }, context: null,
//  );
//}

void _invalidInformation(context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        backgroundColor: Colors.white,
        title: new Text("Invalid Information"),
        content: new Text("Kindly re-enter the correct details."),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showError(e, context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        backgroundColor: Colors.white,
        title: new Text("Error"),
        content: new Text(e.message + "."),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _registrationSuccessful(context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        backgroundColor: Colors.white,
        title: new Text("Registration Successful"),
        content: new Text("Congratulations! You have successfully registered."),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new Home());
              Navigator.of(context).push(router);
            },
          ),
        ],
      );
    },
  );
}

myHeadingStyle() {
  return TextStyle(
    fontFamily: 'OpenSansRegular',
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );
}

bool _isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}

bool validateInformation(
    TextEditingController teamNameController,
    TextEditingController coachNameController,
    TextEditingController noOfStudentsController,
    TextEditingController contactController,
    cricketVal,
    footballVal,
    basketballVal,
    handballVal) {
  if (teamNameController.text != "" &&
      coachNameController.text != "" &&
      noOfStudentsController.text != "" &&
      _isNumeric(noOfStudentsController.text) &&
      contactController.text != "" &&
      _isNumeric(contactController.text) &&
      contactController.text.length == 10 &&
      (cricketVal || footballVal || basketballVal || handballVal)) {
    return true;
  } else {
    return false;
  }
}

tfTo10Converter(bool test) {
  if (test == true)
    return 1;
  else
    return 0;
}

void testingFunction() async {
  var result = await conn.query("desc Fixtures");
  for (var i in result) {
    debugPrint(i[0]);
    debugPrint(i[2]);
  }
//  debugPrint(result);
}

myDrawer(context) {
  _fetchTeamDetails(context);
  return Drawer(
      child: new ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      Container(
          height: 95.0,
          child: DrawerHeader(
            child: new Text(
              'Menu',
              textAlign: TextAlign.center,
              style: new TextStyle(
//          fontFamily: 'Mistral',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            decoration: new BoxDecoration(color: Colors.blue),
          ),
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.all(0.0)),
      ListTile(
        title: Text(
          'Home',
          textAlign: TextAlign.center,
        ),
        onTap: () {
          {
            var router = new MaterialPageRoute(
                builder: (BuildContext context) => new Home());
            Navigator.of(context).push(router);
          }
        },
      ),
      ListTile(
          title: Text('Teams', textAlign: TextAlign.center),
          onTap: () {
            _fetchTeamDetails(context);
            var router = new MaterialPageRoute(
                builder: (BuildContext context) => new Teams());
            Navigator.of(context).push(router);
          }),
      ExpansionTile(
        title: Text(
          'Fixtures',
          textAlign: TextAlign.center,
        ),
        children: <Widget>[
          ListTile(
              title: Text('Team Wise', textAlign: TextAlign.center),
              onTap: () {
                var router = new MaterialPageRoute(
                    builder: (BuildContext context) => new FixturesTeams());
                Navigator.of(context).push(router);
              }),
          ListTile(
              title: Text('Sport Wise', textAlign: TextAlign.center),
              onTap: () {
                var router = new MaterialPageRoute(
                    builder: (BuildContext context) => new FixturesSports());
                Navigator.of(context).push(router);
              })
        ],
      ),
      ExpansionTile(
        title: Text(
          'Standings',
          textAlign: TextAlign.center,
        ),
        children: <Widget>[
          ListTile(
              title: Text('Team Wise', textAlign: TextAlign.center),
              onTap: () {
                var router = new MaterialPageRoute(
                    builder: (BuildContext context) => new StandingsTeams());
                Navigator.of(context).push(router);
              }),
          ListTile(
              title: Text('Sport Wise', textAlign: TextAlign.center),
              onTap: () {
                var router = new MaterialPageRoute(
                    builder: (BuildContext context) => new StandingsSports());
                Navigator.of(context).push(router);
              })
        ],
      ),
      ListTile(
          title: Text(
            'Register Your Team',
            textAlign: TextAlign.center,
          ),
          onTap: () {
            var router = new MaterialPageRoute(
                builder: (BuildContext context) => new TeamRegistration());
            Navigator.of(context).push(router);
          }),
    ],
  ));
}

myAppBar() {
//  BuildContext context;
  return AppBar(
    backgroundColor: Colors.red,
    title: new Text('Sports Portal'),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.power_settings_new),
        onPressed: () => exit(0),
      )
    ],
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: myAppBar(),
      drawer: myDrawer(context),
      body: new Container(
          alignment: Alignment.center,
          margin: new EdgeInsets.symmetric(vertical: 100.0),
          child: new ListView(
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              new Image.asset('images/logo.png', fit: BoxFit.cover),
              new Container(
                  margin: const EdgeInsets.all(2.0),
                  height: 50,
//                  decoration: new BoxDecoration(color: Colors.lightGreenAccent),
                  child: new Text(
                    'WELCOME TO SPORTS PORTAL',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontFamily: 'Mistral',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ))
            ],
          )),
      backgroundColor: Colors.redAccent,
    );
  }
}

class Teams extends StatefulWidget {
  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      drawer: myDrawer(context),
      body: new Container(
          alignment: Alignment.topCenter,
          child: new ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                new Container(
                    margin: const EdgeInsets.all(2.0),
                    child: new Text(
                      'TEAMS',
                      textAlign: TextAlign.center,
                      style: myHeadingStyle(),
                    )),
                new Column(
                  children: <Widget>[
                    new ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listOfTeams.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return new ListTile(
//                          dense: true,
                          title: Text(listOfTeams[index]),
                          subtitle: Text(
                            "Coach Name : ${listOfCoaches[index]}\nContact No. : ${listOfContacts[index]}",
                          ),
                          onTap: () => {},
                        );
                      },
                    )
                  ],
                ),
              ])),
//      backgroundColor: Colors.redAccent,
    );
  }
}

class FixturesTeams extends StatefulWidget {
  @override
  _FixturesTeamsState createState() => _FixturesTeamsState();
}

class _FixturesTeamsState extends State<FixturesTeams> {
  String _currentItemSelected;
  String dropDownStringItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(),
        drawer: myDrawer(context),
        body: new Container(
            alignment: Alignment.topCenter,
            child: new ListView(
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  new Container(
                      margin: const EdgeInsets.all(2.0),
                      child: new Text(
                        'FIXTURES',
                        textAlign: TextAlign.center,
                        style: myHeadingStyle(),
                      )),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Center(
                    child: new basic.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                            hint: Text("Select Team"),
                            items: listOfTeams.map((dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(dropDownStringItem,
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                          new Padding(
                              padding:
                                  new EdgeInsets.only(left: 2.0, right: 2.0)),
                          new RaisedButton(
                            onPressed: () async {
                              if (_currentItemSelected != "") {
                                _fetchFixturesTeamWise(
                                    context, _currentItemSelected);
                                var router = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new FixturesTeamsActive(
                                            _currentItemSelected));
                                Navigator.of(context).push(router);
                              }
                            },
                            color: Colors.red,
                            child: new Text(
                              'Fetch',
                              style: new TextStyle(fontSize: 20),
                            ),
                            textColor: Colors.white,
                          )
                        ]),
                  )
                ])));
  }
}

class FixturesTeamsActive extends StatefulWidget {
  var _currentItemSelected;

  FixturesTeamsActive(String currentItemSelected) {
    _currentItemSelected = currentItemSelected;
  }

  @override
  _FixturesTeamsActiveState createState() =>
      _FixturesTeamsActiveState(_currentItemSelected);
}

class _FixturesTeamsActiveState extends State<FixturesTeamsActive> {
  var _currentItemSelected;
  String dropDownStringItem;

  _FixturesTeamsActiveState(currentItemSelected) {
    _currentItemSelected = currentItemSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(),
        drawer: myDrawer(context),
        body: new Container(
            alignment: Alignment.topCenter,
            child: new ListView(
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  new Container(
                      margin: const EdgeInsets.all(2.0),
                      child: new Text(
                        'FIXTURES',
                        textAlign: TextAlign.center,
                        style: myHeadingStyle(),
                      )),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Center(
                    child: new basic.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                            hint: Text("Select Team"),
                            items: listOfTeams.map((dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(dropDownStringItem,
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                          new Padding(
                              padding:
                                  new EdgeInsets.only(left: 2.0, right: 2.0)),
                          new RaisedButton(
                            onPressed: () async {
                              if (_currentItemSelected != "") {
                                _fetchFixturesTeamWise(
                                    context, _currentItemSelected);
                                var router = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new FixturesTeamsActive(
                                            _currentItemSelected));
                                Navigator.of(context).push(router);
                              }
                            },
                            color: Colors.red,
                            child: new Text(
                              'Fetch',
                              style: new TextStyle(fontSize: 20),
                            ),
                            textColor: Colors.white,
                          )
                        ]),
                  ),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Column(
                    children: <Widget>[
                      new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: fixturesTeamA.length,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return new ListTile(
                            title: Text(
                                "${index + 1} - ${fixturesTeamA[index]} vs ${fixturesTeamB[index]}"),
                            subtitle: Text(
                              "Date : ${fixturesDate[index]}\nWinner : ${fixturesResult[index]}\nSport : ${fixturesSport[index]}",
                            ),
                            onTap: () => {},
                          );
                        },
                      )
                    ],
                  ),
                ])));
  }
}

class FixturesSports extends StatefulWidget {
  @override
  _FixturesSportsState createState() => _FixturesSportsState();
}

class _FixturesSportsState extends State<FixturesSports> {
  String _currentItemSelected;
  String dropDownStringItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(),
        drawer: myDrawer(context),
        body: new Container(
            alignment: Alignment.topCenter,
            child: new ListView(
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  new Container(
                      margin: const EdgeInsets.all(2.0),
                      child: new Text(
                        'FIXTURES',
                        textAlign: TextAlign.center,
                        style: myHeadingStyle(),
                      )),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Center(
                    child: new basic.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                            hint: Text("Select Sport"),
                            items: listOfSports.map((dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(dropDownStringItem,
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                          new Padding(
                              padding:
                                  new EdgeInsets.only(left: 2.0, right: 2.0)),
                          new RaisedButton(
                            onPressed: () async {
                              if (_currentItemSelected != "") {
                                _fetchFixturesSportWise(
                                    context, _currentItemSelected);
                                var router = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new FixturesSportsActive(
                                            _currentItemSelected));
                                Navigator.of(context).push(router);
                              }
                            },
                            color: Colors.red,
                            child: new Text(
                              'Fetch',
                              style: new TextStyle(fontSize: 20),
                            ),
                            textColor: Colors.white,
                          )
                        ]),
                  )
                ])));
  }
}

class FixturesSportsActive extends StatefulWidget {
  String _currentItemSelected;

  FixturesSportsActive(String currentItemSelected) {
    _currentItemSelected = currentItemSelected;
  }

  @override
  _FixturesSportsActiveState createState() =>
      _FixturesSportsActiveState(_currentItemSelected);
}

class _FixturesSportsActiveState extends State<FixturesSportsActive> {
  String _currentItemSelected;
  String dropDownStringItem;

  _FixturesSportsActiveState(String currentItemSelected) {
    _currentItemSelected = currentItemSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(),
        drawer: myDrawer(context),
        body: new Container(
            alignment: Alignment.topCenter,
            child: new ListView(
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  new Container(
                      margin: const EdgeInsets.all(2.0),
                      child: new Text(
                        'FIXTURES',
                        textAlign: TextAlign.center,
                        style: myHeadingStyle(),
                      )),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Center(
                    child: new basic.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                            hint: Text("Select Sport"),
                            items: listOfSports.map((dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(dropDownStringItem,
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                          new Padding(
                              padding:
                                  new EdgeInsets.only(left: 2.0, right: 2.0)),
                          new RaisedButton(
                            onPressed: () async {
                              if (_currentItemSelected != "") {
                                _fetchFixturesSportWise(
                                    context, _currentItemSelected);
                                var router = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new FixturesSportsActive(
                                            _currentItemSelected));
                                Navigator.of(context).push(router);
                              }
                            },
                            color: Colors.red,
                            child: new Text(
                              'Fetch',
                              style: new TextStyle(fontSize: 20),
                            ),
                            textColor: Colors.white,
                          )
                        ]),
                  ),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Column(
                    children: <Widget>[
                      new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: fixturesTeamA.length,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return new ListTile(
                            title: Text(
                                "${index + 1} - ${fixturesTeamA[index]} vs ${fixturesTeamB[index]}"),
                            subtitle: Text(
                              "Date : ${fixturesDate[index]}\nWinner : ${fixturesResult[index]}",
                            ),
                            onTap: () => {},
                          );
                        },
                      )
                    ],
                  ),
                ])));
  }
}

class StandingsTeams extends StatefulWidget {
  @override
  _StandingsTeamsState createState() => _StandingsTeamsState();
}

class _StandingsTeamsState extends State<StandingsTeams> {
  String _currentItemSelected;
  String dropDownStringItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(),
        drawer: myDrawer(context),
        body: new Container(
            alignment: Alignment.topCenter,
            child: new ListView(
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  new Container(
                      margin: const EdgeInsets.all(2.0),
                      child: new Text(
                        'STANDINGS',
                        textAlign: TextAlign.center,
                        style: myHeadingStyle(),
                      )),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Center(
                    child: new basic.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                            hint: Text("Select Team"),
                            items: listOfTeams.map((dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(dropDownStringItem,
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                          new Padding(
                              padding:
                                  new EdgeInsets.only(left: 2.0, right: 2.0)),
                          new RaisedButton(
                            onPressed: () async {
                              if (_currentItemSelected != "") {
                                _fetchStandingsTeamWise(
                                    context, _currentItemSelected);
                                var router = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new StandingsTeamActive(
                                            _currentItemSelected));
                                Navigator.of(context).push(router);
                              }
                            },
                            color: Colors.red,
                            child: new Text(
                              'Fetch',
                              style: new TextStyle(fontSize: 20),
                            ),
                            textColor: Colors.white,
                          )
                        ]),
                  )
                ])));
  }
}

class StandingsTeamActive extends StatefulWidget {
  String _currentItemSelected;

  StandingsTeamActive(String currentItemSelected) {
    _currentItemSelected = currentItemSelected;
  }

  @override
  _StandingsTeamActiveState createState() =>
      _StandingsTeamActiveState(_currentItemSelected);
}

class _StandingsTeamActiveState extends State<StandingsTeamActive> {
  String _currentItemSelected;
  String dropDownStringItem;

  _StandingsTeamActiveState(String currentItemSelected) {
    _currentItemSelected = currentItemSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(),
        drawer: myDrawer(context),
        body: new Container(
            alignment: Alignment.topCenter,
            child: new ListView(
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  new Container(
                      margin: const EdgeInsets.all(2.0),
                      child: new Text(
                        'STANDINGS',
                        textAlign: TextAlign.center,
                        style: myHeadingStyle(),
                      )),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Center(
                    child: new basic.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                            hint: Text("Select Team"),
                            items: listOfTeams.map((dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(dropDownStringItem,
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                          new Padding(
                              padding:
                                  new EdgeInsets.only(left: 2.0, right: 2.0)),
                          new RaisedButton(
                            onPressed: () async {
                              if (_currentItemSelected != "") {
                                _fetchStandingsTeamWise(
                                    context, _currentItemSelected);
                                var router = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new StandingsTeamActive(
                                            _currentItemSelected));
                                Navigator.of(context).push(router);
                              }
                            },
                            color: Colors.red,
                            child: new Text(
                              'Fetch',
                              style: new TextStyle(fontSize: 20),
                            ),
                            textColor: Colors.white,
                          )
                        ]),
                  ),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Column(
                    children: <Widget>[
                      new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: standingTeam.length,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return new ListTile(
                            title: Text(
                                "Sport -> ${standingGameName[index]}    Points = ${standingPoints[index]}"),
                            subtitle: Text(
                              "Won: ${standingWon[index]}    Lost: ${standingLost[index]}    Tie: ${standingDraws[index]}",
                            ),
                            onTap: () => {},
                          );
                        },
                      )
                    ],
                  ),
                ])));
  }
}

class StandingsSports extends StatefulWidget {
  @override
  _StandingsSportsState createState() => _StandingsSportsState();
}

class _StandingsSportsState extends State<StandingsSports> {
  String _currentItemSelected;
  String dropDownStringItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(),
        drawer: myDrawer(context),
        body: new Container(
            alignment: Alignment.topCenter,
            child: new ListView(
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  new Container(
                      margin: const EdgeInsets.all(2.0),
                      child: new Text(
                        'STANDINGS',
                        textAlign: TextAlign.center,
                        style: myHeadingStyle(),
                      )),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Center(
                    child: new basic.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                            hint: Text("Select Sport"),
                            items: listOfSports.map((dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(dropDownStringItem,
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                          new Padding(
                              padding:
                                  new EdgeInsets.only(left: 2.0, right: 2.0)),
                          new RaisedButton(
                            onPressed: () async {
                              if (_currentItemSelected != "") {
                                _fetchStandingsSportWise(
                                    context, _currentItemSelected);
                                var router = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new StandingSportsActive(
                                            _currentItemSelected));
                                Navigator.of(context).push(router);
                              }
                            },
                            color: Colors.red,
                            child: new Text(
                              'Fetch',
                              style: new TextStyle(fontSize: 20),
                            ),
                            textColor: Colors.white,
                          )
                        ]),
                  )
                ])));
  }
}

class StandingSportsActive extends StatefulWidget {
  String _currentItemSelected;

  StandingSportsActive(String currentItemSelected) {
    _currentItemSelected = currentItemSelected;
  }

  @override
  _StandingSportsActiveState createState() =>
      _StandingSportsActiveState(_currentItemSelected);
}

class _StandingSportsActiveState extends State<StandingSportsActive> {
  String _currentItemSelected;
  String dropDownStringItem;

  _StandingSportsActiveState(String currentItemSelected) {
    _currentItemSelected = currentItemSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(),
        drawer: myDrawer(context),
        body: new Container(
            alignment: Alignment.topCenter,
            child: new ListView(
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  new Container(
                      margin: const EdgeInsets.all(2.0),
                      child: new Text(
                        'STANDINGS',
                        textAlign: TextAlign.center,
                        style: myHeadingStyle(),
                      )),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Center(
                    child: new basic.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                            hint: Text("Select Team"),
                            items: listOfSports.map((dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(dropDownStringItem,
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                          new Padding(
                              padding:
                                  new EdgeInsets.only(left: 2.0, right: 2.0)),
                          new RaisedButton(
                            onPressed: () async {
                              if (_currentItemSelected != "") {
                                _fetchStandingsSportWise(
                                    context, _currentItemSelected);
                                var router = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new StandingSportsActive(
                                            _currentItemSelected));
                                Navigator.of(context).push(router);
                              }
                            },
                            color: Colors.red,
                            child: new Text(
                              'Fetch',
                              style: new TextStyle(fontSize: 20),
                            ),
                            textColor: Colors.white,
                          )
                        ]),
                  ),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Column(
                    children: <Widget>[
                      new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: standingTeam.length,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return new ListTile(
                            title: Text(
                                "Position -> ${index + 1}    Team -> ${standingTeam[index]}    Points -> ${standingPoints[index]}"),
                            subtitle: Text(
                              "Won: ${standingWon[index]}    Lost: ${standingLost[index]}    Tie: ${standingDraws[index]}",
                            ),
                            onTap: () => {},
                          );
                        },
                      )
                    ],
                  ),
                ])));
  }
}

class TeamRegistration extends StatefulWidget {
  @override
  _TeamRegistrationState createState() => _TeamRegistrationState();
}

class _TeamRegistrationState extends State<TeamRegistration> {
  final TextEditingController _teamNameController = new TextEditingController();
  final TextEditingController _coachNameController =
      new TextEditingController();
  final TextEditingController _noOfStudentsController =
      new TextEditingController();
  final TextEditingController _contactController = new TextEditingController();
  bool cricketVal = false;
  bool footballVal = false;
  bool basketballVal = false;
  bool handballVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(),
        drawer: myDrawer(context),
        body: new Container(
            alignment: Alignment.topCenter,
            color: Colors.redAccent,
            child: new ListView(padding: const EdgeInsets.all(20.0), children: <
                Widget>[
              new Container(
                  margin: const EdgeInsets.all(2.0),
                  child: new Text(
                    'TEAM REGISTRATION',
                    textAlign: TextAlign.center,
                    style: myHeadingStyle(),
                  )),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                  height: 420.0,
                  width: 500.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  padding: new EdgeInsets.all(7.0),
//                  color: Colors.white,
                  child: new ListView(children: <Widget>[
                    new TextField(
                      controller: _teamNameController,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        labelText: 'Team Name',
                        hintText: 'e.g XYZ College',
                      ),
                    ),
                    new TextField(
                      controller: _coachNameController,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        labelText: 'Coach Name',
                        hintText: 'e.g John Doe',
                      ),
                    ),
                    new TextField(
                      controller: _noOfStudentsController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: 'No. of Students',
                        hintText: 'e.g 17',
                      ),
                    ),
                    new TextField(
                      controller: _contactController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: 'Contact Number',
                        hintText: 'e.g 9876543210',
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(10.0)),
                    new Text(
                      'Select the Sports Your Team Will Participate in:',
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new basic.Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          margin:
                              const EdgeInsets.only(left: 10.5, right: 10.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                value: cricketVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    cricketVal = value;
                                  });
                                },
                              ),
                              Text("Cricket"),
                            ],
                          ),
                        ),
                        new Container(
                          margin:
                              const EdgeInsets.only(left: 10.5, right: 10.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                value: footballVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    footballVal = value;
                                  });
                                },
                              ),
                              Text("Football"),
                            ],
                          ),
                        ),
                        new Container(
                          margin:
                              const EdgeInsets.only(left: 10.5, right: 10.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                value: basketballVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    basketballVal = value;
                                  });
                                },
                              ),
                              Text("Basketball"),
                            ],
                          ),
                        ),
                        new Container(
                          margin:
                              const EdgeInsets.only(left: 10.5, right: 10.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                value: handballVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    handballVal = value;
                                  });
                                },
                              ),
                              Text("Handball"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    new Padding(padding: new EdgeInsets.all(10.0)),
                    new Container(
                        alignment: Alignment.center,
                        child: new RaisedButton(
                          onPressed: () async {
                            if (validateInformation(
                                _teamNameController,
                                _coachNameController,
                                _noOfStudentsController,
                                _contactController,
                                cricketVal,
                                footballVal,
                                basketballVal,
                                handballVal)) {
                              var myQuery = "insert into Teams values(" +
                                  "\"${_teamNameController.text}\"," +
                                  "\"${_coachNameController.text}\"," +
                                  "${_noOfStudentsController.text}," +
                                  "${_contactController.text}," +
                                  "${tfTo10Converter(cricketVal)}," +
                                  "${tfTo10Converter(footballVal)}," +
                                  "${tfTo10Converter(basketballVal)}," +
                                  "${tfTo10Converter(handballVal)}," +
                                  "NULL);";
                              debugPrint(myQuery);
                              var result;
                              var foundException = 0;
                              try {
                                result = await conn.query(myQuery);
                              } catch (e) {
                                showError(e, context);
                                foundException = 1;
                              }
                              if (foundException == 0) {
                                _registrationSuccessful(context);
                              }
                            } else {
                              _invalidInformation(context);
                            }
                          },
                          color: Colors.red,
                          child: new Text(
                            'Register',
                            style: new TextStyle(fontSize: 20),
                          ),
                          textColor: Colors.white,
                        ))
                  ]))
            ])));
  }
}
