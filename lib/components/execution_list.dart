import 'package:flutter/material.dart';
import 'package:rollr/constants.dart';
import 'package:rollr/models/execution.dart';
import 'package:rollr/components/result_icon_button.dart';

class ExecutionList extends StatefulWidget {
  final String selectedExercise;
  final List<ResultIconButton> executionIconList;

  ExecutionList({this.selectedExercise, this.executionIconList});

  @override
  _ExecutionListState createState() => _ExecutionListState();
}

class _ExecutionListState extends State<ExecutionList> {
  List<Execution> _executionList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(15.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: kActiveColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.selectedExercise,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Statistics', //TODO: sostituire con i dati di OK, NON_OK e SO_SO
                    ),
                    SingleChildScrollView(
                      child: Wrap(
                        children: widget.executionIconList,
                        direction: Axis.horizontal,
                        spacing: 0.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  widget.executionIconList.length.toString(),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
