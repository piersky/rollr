import 'package:rollr/models/exercise_summary.dart';

class ExecutionDay {
  final DateTime theDay;
  final List<ExerciseSummary> exerciseListSummary;

  ExecutionDay(this.theDay, this.exerciseListSummary);
}
