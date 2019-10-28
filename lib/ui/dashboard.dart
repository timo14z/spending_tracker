import 'package:flutter/material.dart';
import 'package:spending_tracker/utils/database_helper.dart';
import 'package:spending_tracker/ui/appDrawer.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DashboardState();
  }
}

class DashboardState extends State<Dashboard> {

  var db = new DatabaseHelper();
  double total = 0;

  void _init() async {
    total = await db.getSum();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return new Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade800,
          title: new Text("Your Dashboard"),),
        body: new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(padding: EdgeInsets.all(50.0)),
                  new Text("This month you've spent...", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                  new Padding(padding: EdgeInsets.all(8.0)),
                  new Text("\$$total", style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold)),
                  new Padding(padding: EdgeInsets.all(15.0)),
                  new Text("Your top 3 spinding categories:", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                ],
              ),
            )
        )
    );
  }
}