import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/task/task_importance.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/screens/timer_screen.dart';
import 'package:focus_time/features/tasks/presentation/screens/update_task_screen.dart';
import 'package:intl/intl.dart';

class TaskDetails extends StatelessWidget {
  TaskModel task;

  TaskDetails({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskUsecasesBloc, TaskUsecasesState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<TaskUsecasesBloc>(context);
          if (state is UpdateTaskSuccessState && bloc.currentTask != null) {
            task = bloc.currentTask!;
          }
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 100,
                child: CustomPaint(
                  painter: MyAppBar(
                    color: importanceColor[task.importance]!,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          task.taskName,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        CustomCheckbox(
                          isChecked: task.isCompleted!,
                          onChange: () {
                            task.isCompleted = !task.isCompleted!;
                            bloc.changeIsCompleted(task);
                          },
                          size: 24,
                          iconSize: 20,
                          selectedColor: AppColors.accent,
                          selectedIconColor: Colors.white,
                          borderColor: AppColors.primary,
                          checkIcon: const Icon(Icons.check),
                        )
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Text(
                          task.taskDescription,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Deadline',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        _getDeadlineString(task.deadline.toDate()),
                        style: TextStyle(
                          fontSize: 16,
                          color: _getDeadlineColor(task.deadline.toDate()),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        _getTimerString(task.progressInMinutes),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < (task.score / 15).round(); i++)
                          const Icon(Icons.star),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        _getTimeTechniqueText(task.timeTechnique),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RoundedButton(
                          child: const Text('Start '),
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
                        RoundedButton(
                          child: const Text('Update'),
                          onPressed: () {
                            bloc.currentTask = task;
                            bloc.prepareUpdateScreen();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdateTaskScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  String _getTimeTechniqueText(double timeTechnique) {
    return timeTechnique == 25
        ? 'Your time technique is \n25:00m Work and 05:00 m Brake'
        : 'Your time technique is \n45:00m Work and 15:00 m Brake';
  }

  String _getDeadlineString(DateTime deadline) {
    final date = DateFormat('EEE, dd/MM').format(deadline);
    final time = DateFormat('h:mmaaa').format(deadline);
    return '$date $time';
  }

  Color _getDeadlineColor(DateTime deadline) {
    return deadline.isAfter(DateTime.now()) ? Colors.green : AppColors.error;
  }

  String _getTimerString(Duration timer) {
    int s = timer.inSeconds % 60;
    int m = timer.inMinutes;
    if (s < 10 && m < 10) {
      return '0$m : 0$s';
    } else if (s < 10) {
      return '$m : 0$s';
    } else if (m < 10) {
      return '0$m : $s';
    }
    return '$m : $s';
  }
}

class CustomCheckbox extends StatelessWidget {
  final Function onChange;
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;
  final Color borderColor;
  final Icon checkIcon;

  const CustomCheckbox({
    required this.isChecked,
    required this.onChange,
    required this.size,
    required this.iconSize,
    required this.selectedColor,
    required this.selectedIconColor,
    required this.borderColor,
    required this.checkIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange();
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isChecked ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        width: size,
        height: size,
        child: isChecked
            ? Icon(
                Icons.check,
                color: selectedIconColor,
                size: iconSize,
              )
            : null,
      ),
    );
  }
}

class MyAppBar extends CustomPainter {
  final Color color;

  MyAppBar({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height,
      size.width * 0.49,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.5,
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();

    final painter = Paint()..color = color;
    canvas.drawShadow(path, Colors.black, 4.0, false);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
