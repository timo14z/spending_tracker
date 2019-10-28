class Transaction {
  String _summary;
  String _date;
  double _amount;
  int _id;

  Transaction(this._summary, this._date, this._amount);

  Transaction.map(dynamic obj) {
    this._summary = obj['summary'];
    this._date = obj['date'];
    this._amount = obj['amount'];
    this._id = obj['id'];
  }

  String get summary => _summary;
  String get date => _date;
  double get amount => _amount;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["summary"] = _summary;
    map["date"] = _date;
    map["amount"] = _amount;
    if (id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Transaction.fromMap(Map<String, dynamic> map) {
    this._summary = map["summary"];
    this._date = map["date"];
    this._amount = map["amount"];
    this._id = map["id"];
  }

}