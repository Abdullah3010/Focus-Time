import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/task/task_importance.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_timer/task_timer_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:timer_count_down/timer_count_down.dart';

class TimerScreen extends StatelessWidget {
  final TaskModel task;

  const TimerScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TaskTimerBloc(),
        child: BlocBuilder<TaskTimerBloc, TaskTimerState>(
          builder: (context, state) {
            TaskTimerBloc bloc = BlocProvider.of<TaskTimerBloc>(context);
            if (state is TaskTimerInitial) {
              bloc.taskDurationInSeconds = (task.timeTechnique * 60).toInt();
              bloc.timerRebuildDuration =
                  Duration(seconds: bloc.taskDurationInSeconds ~/ 100);
              bloc.add(StartTimerEvent(task.timeTechnique));
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 70,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Countdown(
                        controller: bloc.timerControler,
                        seconds: bloc.taskDurationInSeconds,
                        interval: const Duration(seconds: 1),
                        onFinished: () {
                          bloc.taskDone(
                              task, BlocProvider.of<TaskUsecasesBloc>(context));
                        },
                        build: (context, second) {
                          Duration remainedDuration =
                              Duration(seconds: second.toInt());
                          bloc.taskProgress += const Duration(seconds: 1);
                          return Stack(
                            children: [
                              _taskProgress(
                                animationDuration: bloc
                                    .timerRebuildDuration.inSeconds
                                    .toDouble(),
                                progress: second /
                                    bloc.timerRebuildDuration.inSeconds,
                                color: importanceColor[task.importance]!,
                              ),
                              SizedBox(
                                height: 300,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        task.taskName,
                                        style: const TextStyle(
                                          fontFamily: 'Times',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      _getTimerString(remainedDuration),
                                      style: const TextStyle(
                                        fontFamily: 'Times',
                                        fontSize: 24,
                                        height: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoundedButton(
                            text: 'Pause',
                            onPressed: () {
                              bloc.pauseTimer();
                            },
                          ),
                          RoundedButton(
                            text: 'Resume',
                            onPressed: () {
                              bloc.resumeTimer();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

String _getTimerString(Duration timer) {
  int s = timer.inSeconds % 60;
  int m = timer.inMinutes % 60;
  if (s < 10 && m < 10) {
    return '0$m : 0$s';
  } else if (s < 10) {
    return '$m : 0$s';
  } else if (m < 10) {
    return '0$m : $s';
  }
  return '$m : $s';
}

Widget _taskProgress({
  required double animationDuration,
  required double progress,
  required Color color,
}) {
  return Transform.scale(
    scaleX: -1,
    child: SizedBox(
      width: 300,
      height: 300,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            showTicks: false,
            showLabels: false,
            startAngle: 130,
            endAngle: 50,
            radiusFactor: 1,
            axisLineStyle: AxisLineStyle(
              thickness: 15,
              color: color,
            ),
            pointers: [
              RangePointer(
                value: progress,
                width: 15,
                color: Colors.grey[300],
                enableAnimation: true,
                animationDuration: animationDuration,
                animationType: AnimationType.linear,
              )
            ],
          ),
        ],
      ),
    ),
  );
}

class MyAppBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.9);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height,
      size.width * 0.53,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.3,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();

    final painter = Paint()..color = AppColors.error;
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
