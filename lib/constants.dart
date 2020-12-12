import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const wikipediaEngLink = 'https://en.wikipedia.org/wiki/Figure_skating';

enum Results {
  OK,
  NOT_OK,
  SO_SO,
}

enum Difficulties {
  JUMPS,
  SPINS,
  CHAINS,
  STEPS,
}

const Map<Difficulties, String> difficultyString = {
  Difficulties.JUMPS: "JUMPS",
  Difficulties.SPINS: "SPINS",
  Difficulties.CHAINS: "CHAINS",
  Difficulties.STEPS: "STEPS"
};

const Map<String, Difficulties> stringDifficulty = {
  "JUMPS": Difficulties.JUMPS,
  "SPINS": Difficulties.SPINS,
  "CHAINS": Difficulties.CHAINS,
  "STEPS": Difficulties.STEPS
};

const List<String> jumpOldList = [
  'SELECT...',
  'SALCHOW',
  'TOELOOP',
  'RITTBERGER',
  'FLIP',
  'LUTZ',
  'AXEL',
  'THOREN',
  'WALLEY',
  'SALTO_DEL_TRE'
];

const List<String> jumpList = [
  'SELECT...',
  'HALF FLIP [0.5]',
  'WALTZ [0.5]',
  'HALF LOOP [1]',
  'HALF LUTZ [0.5]',
  'MAZURKA [0.5]',
  'SPLIT [0.5]',
  'SALCHOW [1]',
  'TOE LOOP [1]',
  'TOE WALLEY [1]',
  'FLIP [1]',
  'INSIDE AXEL [1.5]',
  'LOOP [1]',
  'SPLIT FLIP [1]',
  'WALLEY [1]',
  'LUTZ [1]',
  'ONE-FOOT AXEL [1.5]',
  'AXEL [1.5]',
  'DOUBLE SALCHOW [2]',
  'DOUBLE TOE LOOP [2]',
  'DOUBLE TOE WALLEY [2]',
  'DOUBLE FLIP [2]',
  'DOUBLE LOOP [2]',
  'DOUBLE LUTZ [2]',
  'DOUBLE AXEL [2.5]',
  'TRIPLE TOE LOOP [3]',
  'TRIPLE TOE WALLEY [3]',
  'TRIPLE SALCHOW [3]',
  'TRIPLE LOOP [3]',
  'TRIPLE FLIP [3]',
  'TRIPLE LUTZ [3]',
  'TRIPLE AXEL [3.5]'
];

//https://en.wikipedia.org/wiki/Figure_skating_spins
const List<String> spinList = [
  'SELECT...',
  'BASIC TWO-FOOT SPIN',
  'BASIC ONE-FOOT SPIN',
  'SCRATCH SPIN',
  'BACK SCRATCH',
  'CROSSFOOT SPIN',
  'UPRIGHT FRONT-GRAB SPINS',
  'SHOTGUN SPIN',
  '\"Y\" SPINS',
  '\"A\" SPINS',
  'catchfoot layback',
  'attitude spin',
  'Biellmann spin',
  'Pearl Spin',
  'CAMEL FORWARD',
  'CAMEL SIDEWAY',
  'CAMEL UPWARD'
];

const Map<Results, IconData> resultIconList = {
  Results.OK: FontAwesomeIcons.check,
  Results.NOT_OK: FontAwesomeIcons.times,
  Results.SO_SO: FontAwesomeIcons.flushed,
};
const Map<Results, Color> resultColorList = {
  Results.OK: Colors.green,
  Results.NOT_OK: Colors.red,
  Results.SO_SO: Colors.orangeAccent
};

const Map<Difficulties, IconData> difficultieIconList = {
  Difficulties.JUMPS: FontAwesomeIcons.running,
  Difficulties.SPINS: FontAwesomeIcons.circleNotch,
  Difficulties.CHAINS: FontAwesomeIcons.link,
  Difficulties.STEPS: FontAwesomeIcons.shoePrints
};

const double kBottomHeight = 80.0;
const Color kActiveColor = Color(0xFF101E33);
const Color kInactiveColor = Color(0xFF111328);
const Color kAccentColor = Color(0xFFEB1555);
const Color kIconActiveColor = Color(0xFF8D8E98);
const Color kBackgroundColor = Color(0xFF0A0E21);

const String sAppTitleText = 'Personal Roller Trainer';
const String sExerciseExecutionText = 'Exercise execution';
const String sThisExecutionText = "This execution";

const TextStyle kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8d8e98),
);

const TextStyle kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const TextStyle kLargButtonTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 25.0,
);

const TextStyle kH1Style = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kH2Style = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kResultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kBMITextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);
