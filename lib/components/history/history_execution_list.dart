import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rollr/components/history/history_card_item.dart';
import 'package:rollr/components/history/history_execution_card.dart';
import 'package:rollr/models/execution.dart';
import 'package:rollr/db/home_presenter.dart';
import 'package:rollr/constants.dart';
import 'package:intl/intl.dart';
import 'package:rollr/components/history/history_date_card.dart';

class ExecutionHistoryList extends StatefulWidget {
  final List<Execution> executionList;
  final HomePresenter homePresenter;

  ExecutionHistoryList(
    this.executionList,
    this.homePresenter,
  );

  List<Execution> executions;

  @override
  _ExecutionHistoryListState createState() => _ExecutionHistoryListState();
}

class _ExecutionHistoryListState extends State<ExecutionHistoryList> {
  List<HistoryCard> executionsCardList = List<HistoryCard>();

  @override
  void initState() {
    print("InitState");
    super.initState();
    widget.executions = widget.executionList;
    executionsCardList = generateHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    print("build " + executionsCardList.length.toString());
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        itemCount: executionsCardList == null ? 0 : executionsCardList.length,
        itemBuilder: (BuildContext context, int index) {
          return executionsCardList[index].card(context);
        },
      ),
    );
  }

  displayRecord() {
    widget.homePresenter.updateScreen();
  }

  Future<Null> _onRefresh() async {
    widget.executions = await widget.homePresenter.getExecutions();
    print("OnRefresh " + widget.executions.length.toString());
    setState(() {
      executionsCardList = generateHistoryList();
    });

    return null;
  }

  List<HistoryCard> generateHistoryList() {
    List<HistoryCard> historyCards = <HistoryCard>[];
    bool dateChanged = true;
    bool difficultyChanged = false;
    bool exerciseChanged = false;
    bool addExecutionCard = false;

    Difficulties currentDifficulty;
    String currentExercise = "";
    String currentDate;

    int totalOk = 0;
    int totalNonOk = 0;
    int totalSoSo = 0;
    int index = 0;

    for (Execution execution in widget.executions) {
      if (index != 0) {
        print(index.toString() +
            ") | OK: " +
            totalOk.toString() +
            " | NON OK: " +
            totalNonOk.toString() +
            " | SO SO: " +
            totalSoSo.toString() +
            " | C.E. " +
            currentExercise +
            " | C.D. " +
            (currentDifficulty == null
                ? ""
                : difficultyString[currentDifficulty]));

        if (currentDate ==
            (DateFormat("y-M-d").format(execution.executionTime))) {
          print(index.toString() + ") Stessa data della precedente");
          dateChanged = false;
          if (currentDifficulty == execution.difficulty) {
            print(index.toString() + ") Stessa difficoltà");
            difficultyChanged = false;
            if (currentExercise == execution.exercise) {
              print(index.toString() + ") Stesso esercizio");
              exerciseChanged = false;
            } else {
              print(index.toString() + ") Esercizio diverso");
              exerciseChanged = true;
            }
          } else {
            print(index.toString() + ") Difficoltà diversa");
            difficultyChanged = true;
            exerciseChanged = true;
          }
        } else {
          print(index.toString() + ") Date diverse");
          dateChanged = true;
          exerciseChanged = true;
        }
      } else {
        print(index.toString() + ") Primo passaggio");
        print(index.toString() + ") Aggiungo una card DATA");
        historyCards.add(HistoryDateCard(execution, context));
        dateChanged = false;
      }

      if (dateChanged) {
        historyCards.add(HistoryExecutionCard(
          difficulty: currentDifficulty,
          exercise: currentExercise,
          totalOk: totalOk,
          totalNonOk: totalNonOk,
          totalSoSo: totalSoSo,
          homePresenter: widget.homePresenter,
        ));
        totalOk = totalNonOk = totalSoSo = 0;
        addExecutionCard = false;
        print(index.toString() + ") Aggiungo una card DATA");
        historyCards.add(HistoryDateCard(execution, context));
        dateChanged = false;
      } else
        print(index.toString() + ") Date non cambiate");

      if (difficultyChanged) {
        print(index.toString() +
            ") Difficoltà cambiata, quindi anche l'esercizio cambierà. Aggiungo una card EXECUTION");
        addExecutionCard = true;
        difficultyChanged = exerciseChanged = false;
      } else if (exerciseChanged) {
        print(index.toString() +
            ") Esercizio cambiato. Aggiungo una card EXECUTION");
        addExecutionCard = true;
        exerciseChanged = false;
      }

      execution.result == Results.OK
          ? totalOk++
          : execution.result == Results.NOT_OK ? totalNonOk++ : totalSoSo++;

      if (addExecutionCard || index == widget.executions.length - 1) {
        historyCards.add(HistoryExecutionCard(
          difficulty: currentDifficulty,
          exercise: currentExercise,
          totalOk: totalOk,
          totalNonOk: totalNonOk,
          totalSoSo: totalSoSo,
          homePresenter: widget.homePresenter,
        ));
        totalOk = totalNonOk = totalSoSo = 0;
        addExecutionCard = false;
      }

      currentDifficulty = execution.difficulty;
      currentExercise = execution.exercise;
      currentDate = DateFormat("y-M-d").format(execution.executionTime);

      index++;
    }
    return historyCards;
  }
}
