import 'package:flutter/material.dart';
import 'package:spending_tracker/utils/database_helper.dart';
import 'package:spending_tracker/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';



class TransactionDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TransactionDetailsState();
  }

}

var db = new DatabaseHelper();

class TransactionDetailsState extends State<TransactionDetails> {

  SharedPreferences prefs;
  final TextEditingController summaryController = new TextEditingController();
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController amountController = new TextEditingController();

  bool _validSummary = true;
  bool _validDate = true;
  bool _validAmount = true;

  void _loadData() async {
    prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("id");
    debugPrint(id.toString());
    if (id != null) {
      Transaction transaction = await db.getTransaction(id);
      summaryController.text = transaction.summary;
      dateController.text = transaction.date;
      amountController.text = transaction.amount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: ()=> {
              Navigator.pop(context)
            },
            disabledColor: Colors.white),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () => addTransaction(context),
              icon: Icon(Icons.done, color: Colors.white),
              label: new Text("Save", style: TextStyle(color: Colors.white)))
        ],
        backgroundColor: Colors.blueGrey.shade800,
        title: new Text("Transaction Details"),),
      body: new Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          padding: EdgeInsets.all(18.0),
          child: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: summaryController,
                  decoration: new InputDecoration(
                    labelText: "Summary",
                    errorText: _validSummary?null:"Enter Text !!"
                  ),
                ),
                new TextField(
                  controller: dateController,
                  decoration: new InputDecoration(
                    labelText: "Date",
                    errorText: _validDate?null:"Enter Date in 'hh/mm/yyyy' Format"
                  ),
                ),
                new TextField(
                  controller: amountController,
                  decoration: new InputDecoration(
                    labelText: "Amount",
                    errorText: _validAmount?null:"Enter A valid Number !!"
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
  addTransaction(BuildContext context) {
    setState(() {
      _validSummary = checkSummaryValidity();
      _validDate = checkDateValidity();
      _validAmount = checkAmountValidity();
      if(_validSummary && _validDate && _validAmount) {
        db.saveTransaction(Transaction(summaryController.text,
            dateController.text,
            double.parse(amountController.text)));
        Navigator.pop(context);
      }
    });
  }

  bool checkSummaryValidity(){
    return summaryController.text==""?false:true;
  }

  bool checkDateValidity(){
    return dateController.text==""?false:true;
  }

  bool checkAmountValidity(){
    return double.tryParse(amountController.text)==null?false:true;
  }

}


