import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/widgets/input_field.dart';
import 'package:focus_time/features/groups/presentation/bloc/usecases_bloc/group_usecases_bloc.dart';
import 'package:focus_time/features/groups/presentation/widgets/qr_code_scanner.dart';

class AddMembersForm extends StatelessWidget {
  AddMembersForm({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupUsecasesBloc, GroupUsecasesState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<GroupUsecasesBloc>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      controller: _controller,
                      label: 'Email',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search_rounded),
                        onPressed: () {
                          try {
                            final searshUser = bloc.allUsers.firstWhere(
                              (user) => user.email == _controller.text,
                            );
                            bloc.addMember(searshUser);
                          } catch (e) {
                            //ToDo: Show error message
                          }
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.qr_code_scanner_rounded),
                    onPressed: () {
                      final result = Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => QrCodeScanner(),
                        ),
                      )
                          .then((value) {
                        bloc.add(GetUserEvent(uId: value));
                      });
                    },
                  ),
                ],
              ),
              if (bloc.groupMembers.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: bloc.groupMembers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(bloc.groupMembers[index].email),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
