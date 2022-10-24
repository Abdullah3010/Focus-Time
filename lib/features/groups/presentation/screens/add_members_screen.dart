import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/features/groups/presentation/bloc/usecases_bloc/group_usecases_bloc.dart';

import 'package:focus_time/features/groups/presentation/widgets/add_members_form.dart';

class AddMembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GroupUsecasesBloc>(context).add(GetAllUsersEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Members'),
      ),
      body: Center(
        child: AddMembersForm(),
      ),
    );
  }
}
