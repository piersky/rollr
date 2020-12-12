import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:rollr/components/round_icon_button.dart';
import 'package:rollr/components/execution_list.dart';
import 'package:rollr/components/rect_icon_button.dart';
import 'package:rollr/components/result_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rollr/models/execution.dart';
import 'package:rollr/constants.dart';
import 'package:rollr/db/database_helper.dart';
import 'package:flutter/cupertino.dart';

class ExecutionScreen extends StatefulWidget {
  @override
  _ExecutionScreenState createState() => _ExecutionScreenState();
}

class _ExecutionScreenState extends State<ExecutionScreen> {
  String selectedExercise = 'SELECT...';
  List<String> exerciseList = jumpList;
  Difficulties selectedDifficulty = Difficulties.JUMPS;
  List<ResultIconButton> executionIconList = [];

  //List<Execution> executionList = [];
  DatabaseHelper dbProvider = DatabaseHelper();
  int currentExecutionId;
  //int countPerExercise = 0;
  StreamController<Execution> controllerExecution =
      StreamController<Execution>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RectangularIconButton(
                      text: 'JUMP',
                      icon: difficultieIconList[Difficulties.JUMPS],
                      onPress: () {
                        setState(() {
                          changeDropdownList(Difficulties.JUMPS);
                        });
                      },
                      color: switchColor(Difficulties.JUMPS),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RectangularIconButton(
                      text: 'SPIN',
                      icon: difficultieIconList[Difficulties.SPINS],
                      onPress: () {
                        setState(() {
                          changeDropdownList(Difficulties.SPINS);
                        });
                      },
                      color: switchColor(Difficulties.SPINS),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RectangularIconButton(
                      text: 'CHAINS',
                      icon: difficultieIconList[Difficulties.CHAINS],
                      onPress: () {
                        setState(() {
                          changeDropdownList(Difficulties.CHAINS);
                        });
                      },
                      color: switchColor(Difficulties.CHAINS),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RectangularIconButton(
                      text: 'STEPS',
                      icon: difficultieIconList[Difficulties.STEPS],
                      onPress: () {
                        setState(() {
                          changeDropdownList(Difficulties.STEPS);
                        });
                      },
                      color: switchColor(Difficulties.STEPS),
                    ),
                  ],
                ),
              ),
              Container(
                //Platform.isIOS ? iOSPicker() : androidDropdownButton(),
                child: androidDropdownButton(selectedDifficulty),
                //height: 150.0,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: kActiveColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                        child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              sExerciseExecutionText.toUpperCase(),
                              style: kLabelTextStyle,
                            ),
                            padding: EdgeInsets.only(bottom: 15.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                icon: resultIconList[Results.OK],
                                onPress: () {
                                  setState(() {
                                    print('OK');
                                    performAction(
                                      Results.OK,
                                    );
                                  });
                                },
                                color: resultColorList[Results.OK],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                icon: resultIconList[Results.NOT_OK],
                                onPress: () {
                                  setState(() {
                                    print('NON Ok');
                                    performAction(
                                      Results.NOT_OK,
                                    );
                                  });
                                },
                                color: resultColorList[Results.NOT_OK],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                icon: resultIconList[Results.SO_SO],
                                onPress: () {
                                  setState(() {
                                    print('SO AND SO');
                                    performAction(
                                      Results.SO_SO,
                                    );
                                  });
                                },
                                color: resultColorList[Results.SO_SO],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.undoAlt,
                                onPress: () {
                                  setState(() {
                                    deleteLastExecution();
                                  });
                                },
                                color: Colors.white30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                      child: ExecutionList(
                        selectedExercise: selectedExercise,
                        executionIconList: executionIconList,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color switchColor(Difficulties diff) {
    Color color;
    switch (selectedDifficulty) {
      case Difficulties.JUMPS:
        color = diff == Difficulties.JUMPS ? kIconActiveColor : kInactiveColor;
        break;
      case Difficulties.SPINS:
        color = diff == Difficulties.SPINS ? kIconActiveColor : kInactiveColor;
        break;
      case Difficulties.CHAINS:
        color = diff == Difficulties.CHAINS ? kIconActiveColor : kInactiveColor;
        break;
      case Difficulties.STEPS:
        color = diff == Difficulties.STEPS ? kIconActiveColor : kInactiveColor;
    }
    return color;
  }

  void changeDropdownList(Difficulties difficulty) {
    selectedDifficulty = difficulty;

    switch (difficulty) {
      case Difficulties.JUMPS:
        selectedExercise = 'SELECT...';
        exerciseList = jumpList;
        resetExecutions();
        break;

      case Difficulties.SPINS:
        selectedExercise = 'SELECT...';
        exerciseList = spinList;
        resetExecutions();
        break;

      default:
        print('Not implemented yet');
    }
  }

  void performAction(Results result) {
    if (selectedExercise == 'SELECT...') {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap a button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No exercise selected!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Please, select an exercise before starting to save results.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      addExecution(result);
    }
  }

  DropdownButton<String> androidDropdownButton(Difficulties difficulty) {
    List<DropdownMenuItem<String>> currItems = [];

    for (String exercise in exerciseList) {
      var newItem = DropdownMenuItem(
        child: Text(exercise),
        value: exercise,
      );
      currItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedExercise,
      items: currItems,
      isExpanded: true,
      onChanged: (value) {
        setState(() {
          selectedExercise = value;
          resetExecutions();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> cupertinoItems = [];

    for (String exercise in jumpList) {
      cupertinoItems.add(Text(exercise));
    }

    return CupertinoPicker(
      //backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: cupertinoItems,
    );
  }

  void addExecution(Results result) {
    executionIconList.add(ResultIconButton(result: result));
    _save(result);
  }

  void deleteLastExecution() {
    executionIconList.removeLast();
    //_deleteLast();
  }

  void resetExecutions() {
    executionIconList.clear();
  }

  void _save(Results result) async {
    final execution = Execution(selectedExercise, result, selectedDifficulty);
    var resultInsert = await dbProvider.insertExecution(execution);
    if (resultInsert == 0) {
      print('Error: No executions saved!');
    } else {
      currentExecutionId = resultInsert;
      print("New id = $currentExecutionId - Diff: $selectedDifficulty");
      controllerExecution.add(execution);
    }
  }

//  void _deleteLast() async {
//    if (executionIconList.length > 0) {
//      var resultDelete = await dbProvider.deleteExecution(currentExecutionId);
//      if (resultDelete == 0) {
//        print('Error: No executions deleted!');
//      }
//    }
//  }
}
