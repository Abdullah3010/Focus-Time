import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_timer_event.dart';
part 'task_timer_state.dart';

class TaskTimerBloc extends Bloc<TaskTimerEvent, TaskTimerState> {
  TaskTimerBloc() : super(TaskTimerInitial()) {
    on<TaskTimerEvent>((event, emit) {
      if (event is StartTimerEvent) {
        startTimer(event.timeTechnique);
      }
    });
  }

  double progress = 0;
  late Timer timer;
  Duration taskDuration = const Duration();
  Duration taskProgress = const Duration(minutes: 0);

  void startTimer(double timeInMinutes) {
    double timeInSecond = (timeInMinutes * 60);
    taskDuration = Duration(seconds: timeInSecond.toInt());
    final double progressFactory = 100 / timeInSecond;
    emit(TimerStartedState(progress));
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) async {
        progress += progressFactory;
        timeInSecond -= 1;

        if (progress > 100) {
          timer.cancel();
          final player = AudioPlayer();
          await player.play(AssetSource('audio/time_finished.mp3'));
          print(taskDuration.inSeconds);
          print(taskProgress.inSeconds);
          emit(TimerFinishedState());
        } else {
          taskDuration = Duration(seconds: timeInSecond.toInt());
          taskProgress = Duration(minutes: taskProgress.inSeconds + 1);
          emit(TimerStartedState(progress));
        }
      },
    );
  }

  void pauseTimer() {
    timer.cancel();
    print(taskDuration.inMinutes);
    emit(TimerPausedState());
  }

  void resumeTimer() {
    print("ttttttt" + taskDuration.inMinutes.toDouble().toString());
    startTimer(taskDuration.inSeconds/60);
    emit(TimerResumedState());
  }
}
