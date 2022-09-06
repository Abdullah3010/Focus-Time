import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/task/task_importance.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_timer/task_timer_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimerScreen extends StatefulWidget {
  final TaskModel task;

  const TimerScreen({required this.task});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late TaskTimerBloc bloc;

  @override
  void dispose() {
    bloc.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TaskTimerBloc(),
        child: BlocConsumer<TaskTimerBloc, TaskTimerState>(
          listener: (context, state) {
            if (state is TimerFinishedState) {
              final tasksUsecasesBloc =
                  BlocProvider.of<TaskUsecasesBloc>(context);
              //  tasksUsecasesBloc.currentTask!.progressInMinutes.inMinutes;
              final progressedTask = widget.task
                ..progressInMinutes = widget.task.progressInMinutes +
                    BlocProvider.of<TaskTimerBloc>(context).taskProgress
                ..score = widget.task.score +
                    (BlocProvider.of<TaskTimerBloc>(context)
                            .taskProgress
                            .inMinutes *
                        0.6);
              tasksUsecasesBloc.currentTask = progressedTask;
              tasksUsecasesBloc.add(UpdateTaskEvent(task: progressedTask));
            }
          },
          builder: (context, state) {
            bloc = BlocProvider.of<TaskTimerBloc>(context);
            if (state is TaskTimerInitial) {
              bloc.add(StartTimerEvent(widget.task.timeTechnique));
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
                      Stack(
                        children: [
                          _taskProgress(
                            progress: bloc.progress,
                            color: importanceColor[widget.task.importance]!,
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
                                    widget.task.taskName,
                                    style: const TextStyle(
                                      fontFamily: 'Times',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  _getTimerString(bloc.taskDuration),
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoundedButton(
                            child: Text('| |'),
                            onPressed: () {
                              bloc.pauseTimer();
                            },
                          ),
                          RoundedButton(
                            child: Text('|>'),
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
  required double progress,
  required Color color,
}) {
  return SizedBox(
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
          axisLineStyle: const AxisLineStyle(
            thickness: 15,
          ),
          pointers: [
            RangePointer(
              value: progress,
              width: 15,
              color: color,
              enableAnimation: true,
              animationDuration: 1000,
              animationType: AnimationType.linear,
            )
          ],
        ),
      ],
    ),
  );
}

/****
 * 
  SizedBox(
            width: double.infinity,
            height: 140,
            child: CustomPaint(
              painter: MyAppBar(),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      task.taskName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text(
                        'score : ${task.score.toString()}',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(task.taskDescription),
          const SizedBox(
            height: 100,
          ),
          const SizedBox(
            height: 100,
          ),
          RoundedButton(
            child: Text('start'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TimerScreen(
                    task: task,
                  ),
                ),
              );
            },
          ),
        
 * 
 */
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
