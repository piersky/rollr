import 'package:rollr/components/history/history_card_item.dart';
import 'package:rollr/models/execution.dart';
import 'package:flutter/material.dart';
import 'package:rollr/constants.dart';
import 'package:rollr/db/home_presenter.dart';

class HistoryExecutionCard implements HistoryCard {
  final Difficulties difficulty;
  final String exercise;
  final int totalOk;
  final int totalNonOk;
  final int totalSoSo;
  final HomePresenter homePresenter;

  HistoryExecutionCard({
    @required this.difficulty,
    @required this.exercise,
    @required this.totalOk,
    @required this.totalNonOk,
    @required this.totalSoSo,
    this.homePresenter,
  });

  Widget card(BuildContext context) {
    return Card(
      child: Container(
        child: Center(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                child: Icon(difficultieIconList[difficulty]),
                backgroundColor: const Color(0xFF20283e),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          exercise,
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            totalOk.toString(),
                            style: kBodyTextStyle,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            resultIconList[Results.OK],
                            color: resultColorList[Results.OK],
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            totalNonOk.toString(),
                            style: kBodyTextStyle,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            resultIconList[Results.NOT_OK],
                            color: resultColorList[Results.NOT_OK],
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            totalSoSo.toString(),
                            style: kBodyTextStyle,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            resultIconList[Results.SO_SO],
                            color: resultColorList[Results.SO_SO],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: const Color(0xFF167F67),
                    ),
                    onPressed: () => {print("Click delete")},
                  ),
                ],
              ),
            ],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
          10.0,
          0.0,
          0.0,
          0.0,
        ),
      ),
    );
  }
}
