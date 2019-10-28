import 'package:flutter/material.dart';
import 'package:spending_tracker/ui/dashboard.dart';
import 'package:spending_tracker/ui/transactions.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            color: Colors.blueGrey.shade800,
            height: 56,
            padding: EdgeInsets.fromLTRB(10.0, 2.5, 0.0, 0.0),
            child: new DrawerHeader(
              child: new Text("Menu",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  )
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.all(5.0)),
          new ListTile(
            leading: Icon(Icons.dashboard),
            title: new Text("Dashboard"),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
          new ListTile(
            leading: Icon(Icons.monetization_on),
            title: new Text("Transactions"),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Transactions()));
            },
          ),
        ],
      ),
    );
  }
}