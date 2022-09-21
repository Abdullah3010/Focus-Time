import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/core/widgets/stretch_scroll_widget.dart';
import 'package:focus_time/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:focus_time/features/settings/presentation/bloc/settings_bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StretchScrollWidget(
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                BlocProvider.of<SettingsBloc>(context)
                    .add(SwitchThemeModeEvent());
              },
              icon: Icon(Icons.dark_mode),
            ),
            RoundedButton(
              text: 'log Out',
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
