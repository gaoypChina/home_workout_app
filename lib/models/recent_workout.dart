class RecentWorkout {
 late String _date;
 late String _workoutTitle;
 late int _activeTime;
 late double _calories;
 late int _stars;
  int? _id;
 late  int _exercise;

  RecentWorkout(
    this._date,
    this._workoutTitle,
    this._activeTime,
    this._stars,
    this._calories,
    this._exercise,
  );

  RecentWorkout.map(dynamic obj) {
    this._date = obj['date'];
    this._workoutTitle = obj['workoutTitle'];
    this._activeTime = obj['activeTime'];
    this._calories = obj['calories'];
    this._stars = obj['stars'];
    this._id = obj['id'];
    this._exercise = obj['exercise'];
  }

  String get date => _date;

  String get workoutTitle => _workoutTitle;

  int get activeTime => _activeTime;

  int? get id => _id;

  int get stars => _stars;

  double get calories => _calories;

  int get exercise => _exercise;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = _date;
    map["workoutTitle"] = _workoutTitle;
    map["activeTime"] = _activeTime;
    map["calories"] = _calories;
    map["stars"] = _stars;
    map["exercise"] = _exercise;
    if (id != null) {
      map["id"] = _id;
    }
    return map;
  }

  RecentWorkout.fromMap(Map<String, dynamic> map) {
    this._date = map["date"];
    this._workoutTitle = map["workoutTitle"];
    this._activeTime = map["activeTime"];
    this._id = map["id"];
    this._calories = map["calories"];
    this._stars = map["stars"];
    this._exercise = map["exercise"];
  }
}
