part of 'task_timer_bloc.dart';

abstract class TaskTimerState extends Equatable {
  const TaskTimerState();

  @override
  List<Object> get props => [];
}

class TaskTimerInitial extends TaskTimerState {}

class TimerStartedState extends TaskTimerState {
  final double value;

  const TimerStartedState(this.value);
  @override
  List<Object> get props => [value];
}

class TimerPausedState extends TaskTimerState {}

class TimerResumedState extends TaskTimerState {}

class TimerFinishedState extends TaskTimerState {}
