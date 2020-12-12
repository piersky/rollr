import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rollr/components/history/history_card_item.dart';
import 'package:rollr/constants.dart';
import 'package:rollr/models/execution.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:rollr/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class HistoryDateCard implements HistoryCard {
  final Execution execution;
  final BuildContext context;

  HistoryDateCard(this.execution, this.context);

  Widget card(BuildContext context) {
    return Card(
      color: kBackgroundColor,
      child: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 18.0,
              ),
              Expanded(
                child: Text(
                  DateFormat("d MMM yy").format(execution.executionTime),
                  style: kH2Style,
                  textAlign: TextAlign.center,
                ),
              ),
              RawMaterialButton(
                elevation: 6.0,
                onPressed: showAlertDialog,
                shape: CircleBorder(),
                //fillColor: color,
                constraints: BoxConstraints.tightFor(
                  width: 32.0,
                  height: 32.0,
                ),
                child: Icon(
                  FontAwesomeIcons.shareAlt,
                  size: 18.0,
                  color: const Color(0xFF167F67),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog() {
    print("Oggi " + DateFormat("d MMM yy").format(execution.executionTime));
    final emailController = TextEditingController();

    Widget cancelButton = FlatButton(
      child: Text("CANCEL"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("SEND"),
      onPressed: () {
        sendEmail(emailController.text);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('EMAIL ADDRESS'),
      content: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Please, enter a valid email.'),
          ),
        ),
      ),
      actions: <Widget>[cancelButton, continueButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> getExecutions() async {
    Future<Database> db = DatabaseHelper().db;
    List<HistoryCard> listCard;
    var result = await db.query(
      'execution',
      where: 'strftime(\'%Y-%m-%d\', execution_time) = ?',
      whereArgs: [DateFormat("Y-m-d").format(execution.executionTime)],
      orderBy: 'execution_time ASC',
    );

    List<Execution> list = result.isNotEmpty
        ? result.map((c) => Execution.fromMap(c)).toList()
        : null;

    for (Execution l in list) {
      print(
          "queryDate: ID ${l.id} - Execution time = ${l.executionTime} - Exercise ${l.exercise} - Result ${l.result} - Difficulty ${l.difficulty}");
    }
  }

  Future<void> sendEmail(String addresses) async {
    print(addresses);
    StringBuffer htmlBody = StringBuffer();
    htmlBody.write("TODAY WORK OUT");
    htmlBody.writeln(execution.executionTimeString);
    htmlBody.writeln(execution.exercise);

    final Email email = Email(
      body: htmlBody.toString(),
      subject: 'Email subject',
      recipients: [addresses],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print(error.toString());
    }
  }
}
