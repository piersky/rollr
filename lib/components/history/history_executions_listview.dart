import 'package:flutter/material.dart';
import 'package:rollr/models/execution.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Executions extends StatelessWidget {
  final List<Execution> execs;
  Executions(this.execs);

  Widget _buildExecutionItem(BuildContext context, int index) {
    return Card(
      child: Row(
        children: <Widget>[
          Icon(FontAwesomeIcons.running),
          Column(
            children: <Widget>[
              Text("SALCHOW"),
              Text("5 Ok - 4 Not Ok - 2 ="),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildExecutionItem,
      itemCount: execs.length,
    );
  }
}
