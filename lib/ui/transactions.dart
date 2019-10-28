import 'package:flutter/material.dart';
import 'package:spending_tracker/utils/database_helper.dart';
import 'package:spending_tracker/models/transaction.dart';
import 'package:spending_tracker/ui/appDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spending_tracker/ui/transactionDetails.dart';




class Transactions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TransactionsState();
  }
}

class TransactionsState extends State<Transactions> {

  var db = new DatabaseHelper();
  SharedPreferences prefs;
  List _transactions = new List(0);

  Future _init() async {
    _transactions = await db.getAllTransactions();
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return new Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title: new Text("Your Transactions"),),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new ListView.builder(
            itemCount: _transactions.length,
            padding: const EdgeInsets.only(left: 10.0),
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                title: new Text(Transaction.fromMap(_transactions[position]).summary),
                subtitle: new Text(Transaction.fromMap(_transactions[position]).date,
                  style: TextStyle(color: Colors.blueGrey,
                    fontSize: 12.0)),
                trailing: new Text("\$${Transaction.fromMap(_transactions[position]).amount.toString()}",
                  style: TextStyle(color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0)),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade800,
        onPressed: () => goToAddTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }

  goToAddTransaction(BuildContext context) {
    if(prefs.containsKey("id"))
      prefs.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionDetails()));
  }
}