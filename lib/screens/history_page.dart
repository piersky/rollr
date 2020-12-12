import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rollr/components/history/history_card_item.dart';
import 'package:rollr/components/history/history_date_card.dart';
import 'package:rollr/components/history/history_execution_card.dart';
import 'package:rollr/constants.dart';
import 'package:rollr/models/execution.dart';
import 'package:rollr/db/home_presenter.dart';
import 'package:rollr/components/history/history_execution_list.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryState();
  }
}

class _HistoryState extends State<HistoryPage> implements HomeContract {
  HomePresenter homePresenter;

  @override
  void initState() {
    super.initState();
    homePresenter = HomePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(
            "HISTORY",
            style: kH1Style,
          ),
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            //  color: kInactiveColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Execution>>(
            future: homePresenter.getExecutions(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ExecutionHistoryList(
                  snapshot.data,
                  homePresenter,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  void screenUpdate() {
    print("Aggiornato?");
  }

  displayRecord() {
    setState(() {
      print("Display record");
    });
  }
}
