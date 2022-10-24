import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/task/task_importance.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/core/widgets/my_date_picker.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';
import 'package:focus_time/features/groups/presentation/bloc/usecases_bloc/group_usecases_bloc.dart';
import 'package:focus_time/features/groups/presentation/screens/add_members_screen.dart';
import 'package:focus_time/features/home/presentation/screens/home_screen.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/tasks_pages/tasks_bloc.dart';
import 'package:focus_time/features/tasks/presentation/widgets/dropdown.dart';

import 'package:focus_time/core/widgets/input_field.dart';

class CreateGroupForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupUsecasesBloc, GroupUsecasesState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = BlocProvider.of<GroupUsecasesBloc>(context);
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(
                  controller: bloc.groupNameController,
                  label: 'Group Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Group name can't be empty";
                    }
                    return null;
                  },
                ),
                InputField(
                  controller: bloc.groupDescriptionController,
                  label: 'Group Description',
                  maxLines: 6,
                ),
                RoundedButton(
                  text: 'Add Members',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddMembersScreen(),
                      ),
                    );
                  },
                ),

                // InputField(
                //   controller: bloc.deadlineController,
                //   label: 'Deadline',
                //   keyboardType: TextInputType.datetime,
                //   suffixIcon: IconButton(
                //     icon: const Icon(Icons.calendar_month),
                //     padding: const EdgeInsets.only(right: 15),
                //     onPressed: () => _pickBirthdate(bloc, context),
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Deadline can't be empty";
                //     }
                //     return null;
                //   },
                // ),
                // MiraiImportanceDropdownWidget<String>(
                //   valueNotifier: bloc.importanceValue,
                //   itemWidgetBuilder: (int index, String item) {
                //     return MiraiImportanceItemWidget(item: item);
                //   },
                //   children: importanceString.keys.toList(),
                //   focused: bloc.importanceFocused,
                //   onChanged: (String value) {
                //     if (!bloc.importanceFocused) {
                //       bloc.importanceFocused = true;
                //     }
                //     bloc.changeImportanceValue(value);
                //   },
                // ),
                // MiraiTimeTechnequeDropdownWidget<String>(
                //   valueNotifier: bloc.timeTechniqueValue,
                //   itemWidgetBuilder: (int index, String item) {
                //     return MiraiTimeTechniqueItemWidget(item: item);
                //   },
                //   children: timeTechnique.keys.toList(),
                //   focused: bloc.timeTechniqueFocused,
                //   onChanged: (String value) {
                //     if (!bloc.timeTechniqueFocused) {
                //       bloc.timeTechniqueFocused = true;
                //     }
                //     bloc.changeTimeTechniqueValue(value);
                //   },
                // ),

                RoundedButton(
                  text: 'add task',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      bloc.add(
                        CreateGroupEvent(
                          groupName: bloc.groupNameController.text,
                          groupDescription:
                              bloc.groupDescriptionController.text,
                          groupMembers: bloc.groupMembers
                              .map((user) => user.userId!)
                              .toList(),
                          groupOwner: CurrentUser.get()!,
                        ),
                      );
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
