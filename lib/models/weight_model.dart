class WeightModel {
  String _date;
  double _weight;
  int _id;
  String _key;

  WeightModel(this._date, this._weight, this._key);

  WeightModel.map(dynamic obj) {
    this._date = obj['date'];
    this._weight = obj['weight'];
    this._id = obj['id'];
    this._key = obj['key'];
  }

  String get date => _date;
  double get weight => _weight;
  int get id => _id;
  String get key => _key;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = _date;
    map["weight"] = _weight;
    map["key"] = _key;
    if (id != null) {
      map["id"] = _id;
    }
    return map;
  }

  WeightModel.fromMap(Map<String, dynamic> map) {
    this._date = map["date"];
    this._weight = map["weight"];
    this._key = map["key"];
    this._id = map["id"];
  }
}
