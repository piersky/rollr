import 'package:rollr/db/database_helper.dart';
import 'package:rollr/models/execution.dart';
import 'dart:async';

abstract class HomeContract {
  void screenUpdate();
}

class HomePresenter {
  HomeContract _view;
  var db = new DatabaseHelper();
  HomePresenter(this._view);
  delete(Execution execution) {
    var db = new DatabaseHelper();
    db.deleteExecution(execution.id);
    updateScreen();
  }

  Future<List<Execution>> getExecutions() {
    return db.queryAllExecutions();
    //return db.queryExecutions4History();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}
