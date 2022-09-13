import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/task/task_importance.dart';
import 'package:focus_time/core/widgets/my_date_picker.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/home/presentation/screens/home_screen.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/tasks_pages/tasks_bloc.dart';
import 'package:focus_time/features/tasks/presentation/widgets/dropdown.dart';

import 'package:focus_time/core/widgets/input_field.dart';

class AddTaskForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskUsecasesBloc, TaskUsecasesState>(
      listener: (context, state) {
        if (state is AddTaskSuccessState) {
          final bloc = BlocProvider.of<TaskUsecasesBloc>(context);
          bloc.clearAllFields();
          BlocProvider.of<TasksBloc>(context)
              .add(const ChangeTabBarPageEvent(1));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<TaskUsecasesBloc>(context);
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(
                  controller: bloc.taskNameController,
                  label: 'Task Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Task name can't be empty";
                    }
                    return null;
                  },
                ),
                InputField(
                  controller: bloc.taskDescriptionController,
                  label: 'Task Description',
                  maxLines: 6,
                ),
                InputField(
                  controller: bloc.deadlineController,
                  label: 'Deadline',
                  keyboardType: TextInputType.datetime,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month),
                    padding: const EdgeInsets.only(right: 15),
                    onPressed: () => _pickBirthdate(bloc, context),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Deadline can't be empty";
                    }
                    return null;
                  },
                ),
                MiraiImportanceDropdownWidget<String>(
                  valueNotifier: bloc.importanceValue,
                  itemWidgetBuilder: (int index, String item) {
                    return MiraiImportanceItemWidget(item: item);
                  },
                  children: importanceString.keys.toList(),
                  focused: bloc.importanceFocused,
                  onChanged: (String value) {
                    if (!bloc.importanceFocused) {
                      bloc.importanceFocused = true;
                    }
                    bloc.changeImportanceValue(value);
                  },
                ),
                MiraiTimeTechnequeDropdownWidget<String>(
                  valueNotifier: bloc.timeTechniqueValue,
                  itemWidgetBuilder: (int index, String item) {
                    return MiraiTimeTechniqueItemWidget(item: item);
                  },
                  children: timeTechnique.keys.toList(),
                  focused: bloc.timeTechniqueFocused,
                  onChanged: (String value) {
                    if (!bloc.timeTechniqueFocused) {
                      bloc.timeTechniqueFocused = true;
                    }
                    bloc.changeTimeTechniqueValue(value);
                  },
                ),
                RoundedButton(
                  child: const Text('Add task'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newTask = TaskModel(
                        taskName: bloc.taskNameController.text,
                        taskDescription: bloc.taskDescriptionController.text,
                        deadline: Timestamp.fromDate(bloc.deadlineDate!),
                        timeTechnique: bloc.getTimeTechniqueString(
                            bloc.timeTechniqueValue.value),
                        score: 0,
                        isCompleted: false,
                        createTime: Timestamp.now(),
                        progressInMinutes: const Duration(minutes: 0),
                        importance: bloc
                            .getImportanceString(bloc.importanceValue.value),
                      );
                      bloc.add(AddTaskEvent(task: newTask));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickBirthdate(TaskUsecasesBloc bloc, BuildContext context) async {
    final myPicker = MyDateTimePicker(
      context: context,
      title: 'Deadline',
      withTime: true,
    );
    myPicker.getDate().then((value) => bloc.pickDate(value));
  }
}
