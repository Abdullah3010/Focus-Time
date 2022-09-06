import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/task/task_importance.dart';
import 'package:focus_time/core/widgets/input_field.dart';
import 'package:focus_time/core/widgets/my_date_picker.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/widgets/dropdown.dart';

class UpdateTaskScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TaskUsecasesBloc, TaskUsecasesState>(
        listener: (context, state) {
          if (state is UpdateTaskSuccessState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<TaskUsecasesBloc>(context);

          return SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  InputField(
                    controller: bloc.updatedTaskNameController,
                    label: 'Task Name',
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Task name can't be empty";
                      }
                      return null;
                    }),
                  ),
                  InputField(
                    controller: bloc.updatedTaskDescriptionController,
                    label: 'Task Description',
                    maxLines: 6,
                  ),
                  InputField(
                    controller: bloc.updatedDeadlineController,
                    label: 'Deadline',
                    keyboardType: TextInputType.datetime,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      padding: const EdgeInsets.only(right: 15),
                      onPressed: () => _pickBirthdate(bloc, context),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        bloc.updatedDeadlineDate =
                            bloc.currentTask!.deadline.toDate();
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 22,
                      left: 22,
                      bottom: 20,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'The tecnice',
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  MiraiImportanceDropdownWidget(
                    valueNotifier: bloc.updatedImportanceValue,
                    itemWidgetBuilder: (int index, String item) {
                      return MiraiImportanceItemWidget(item: item);
                    },
                    children: importanceString.keys.toList(),
                    focused: bloc.updatedImportanceFocused,
                    onChanged: (String value) {
                      if (!bloc.updatedImportanceFocused) {
                        bloc.updatedImportanceFocused = true;
                      }
                      bloc.changeImportanceValue(
                        value,
                        isUpdated: true,
                      );
                    },
                  ),
                  MiraiTimeTechnequeDropdownWidget<String>(
                    valueNotifier: bloc.updatedTimeTechniqueValue,
                    itemWidgetBuilder: (int index, String item) {
                      return MiraiTimeTechniqueItemWidget(item: item);
                    },
                    children: timeTechnique.keys.toList(),
                    focused: bloc.updatedTimeTechniqueFocused,
                    onChanged: (String value) {
                      if (!bloc.updatedTimeTechniqueFocused) {
                        bloc.updatedTimeTechniqueFocused = true;
                      }
                      bloc.changeTimeTechniqueValue(
                        value,
                        isUpdated: true,
                      );
                    },
                  ),
                  RoundedButton(
                    child: const Text('Update Task'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final newTask = TaskModel(
                          taskId: bloc.currentTask!.taskId,
                          taskName: bloc.updatedTaskNameController.text,
                          taskDescription:
                              bloc.updatedTaskDescriptionController.text,
                          deadline:
                              Timestamp.fromDate(bloc.updatedDeadlineDate!),
                          timeTechnique: bloc.getTimeTechniqueString(
                              bloc.updatedTimeTechniqueValue.value),
                          score: bloc.currentTask!.score,
                          isCompleted: bloc.currentTask!.isCompleted,
                          createTime: bloc.currentTask!.createTime,
                          progressInMinutes:
                              bloc.currentTask!.progressInMinutes,
                          importance: bloc.getImportanceString(
                              bloc.updatedImportanceValue.value),
                        );
                        bloc.currentTask = newTask;
                        bloc.add(UpdateTaskEvent(task: newTask));
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _pickBirthdate(TaskUsecasesBloc bloc, BuildContext context) async {
    final myPicker = MyDateTimePicker(
      context: context,
      title: 'Deadline',
      withTime: true,
    );
    myPicker.getDate().then((value) => bloc.pickDate(value, isUpdated: true));
  }
}
