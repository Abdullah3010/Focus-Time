
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:timer_count_down/timer_controller.dart';

part 'task_timer_event.dart';
part 'task_timer_state.dart';

class TaskTimerBloc extends Bloc<TaskTimerEvent, TaskTimerState> {
  TaskTimerBloc() : super(TaskTimerInitial()) {
    on<TaskTimerEvent>((event, emit) {
      if (event is StartTimerEvent) {
        taskDurationInSeconds = (event.timeTechnique * 60).toInt();
        timerRebuildDuration = Duration(
            milliseconds: ((taskDurationInSeconds / 100) * 1000).toInt());
        startTimer(event.timeTechnique);
      }
    });
  }

  double progress = 0;
  int taskDurationInSeconds = 0;
  Duration taskDuration = const Duration();
  Duration timerRebuildDuration = const Duration(seconds: 100);
  Duration taskProgress = const Duration(seconds: 0);
  CountdownController timerControler = CountdownController();
  void startTimer(double timeInMinutes) {
    timerControler.start();
    emit(TimerStartedState(progress));
  }

  void taskDone(TaskModel task, TaskUsecasesBloc bloc) async {
    final player = AudioPlayer();
    await player.play(AssetSource('audio/time_finished.mp3'));
    final progressedTask = task
      ..progressInMinutes = task.progressInMinutes + taskProgress
      ..score = task.score + taskProgress.inMinutes * 0.6;
    bloc.currentTask = progressedTask;
    bloc.add(UpdateTaskEvent(task: progressedTask));
    emit(TimerFinishedState());
  }

  void pauseTimer() {
    timerControler.pause();
    emit(TimerPausedState());
  }

  void resumeTimer() {
    // print("ttttttt" + taskDuration.inMinutes.toDouble().toString());
    // startTimer(taskDuration.inSeconds / 60);
    timerControler.resume();
    emit(TimerResumedState());
  }
}
