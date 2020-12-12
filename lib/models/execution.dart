import 'package:intl/intl.dart';
import 'package:rollr/constants.dart';

class Execution {
  int _id;
  DateTime _executionTime;
  String _exercise;
  Results _result;
  Difficulties _difficulty;

  Execution(String exercise, Results result, Difficulties difficulty) {
    //_executionTime = DateTime.now();
    _exercise = exercise;
    _result = result;
    _difficulty = difficulty;
  }

  Map<String, dynamic> toMap() => {
        "id": _id,
        //"execution_time": DateFormat("y-M-d H:mm:ss").format(_executionTime),
        "exercise": _exercise,
        "result":
            (_result == Results.OK ? 0 : (_result == Results.NOT_OK ? 1 : 2)),
        "difficulty": difficultyString[_difficulty],
      };

  Execution.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _executionTime = DateFormat("y-M-d H:mm:ss").parse(map['execution_time']);
    _exercise = map['exercise'];
    _result = map['result'] == 0
        ? Results.OK
        : (map['result'] == 1 ? Results.NOT_OK : Results.SO_SO);
    _difficulty = stringDifficulty[map['difficulty']];
  }

  int get id => _id;
  DateTime get executionTime => _executionTime;
  String get executionTimeString =>
      DateFormat("y-M-d H:mm:ss").format(_executionTime);
  String get exercise => _exercise;
  Results get result => _result;
  Difficulties get difficulty => _difficulty;

  set id(int newId) {
    _id = newId;
  }
}
