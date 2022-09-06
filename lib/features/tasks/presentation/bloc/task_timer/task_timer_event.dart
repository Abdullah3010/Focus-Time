part of 'task_timer_bloc.dart';

abstract class TaskTimerEvent extends Equatable {
  const TaskTimerEvent();

  @override
  List<Object> get props => [];
}

class StartTimerEvent extends TaskTimerEvent {
  final double timeTechnique;

  const StartTimerEvent(this.timeTechnique);
  @override
  List<Object> get props => [];
}
