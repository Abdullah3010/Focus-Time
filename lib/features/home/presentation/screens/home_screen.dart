import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    final navBarItems = [
      _navBarItem(FontAwesomeIcons.earthAfrica, 'World'),
      _navBarItem(Icons.grid_3x3, 'Matrix'),
      _navBarItem(Icons.task_alt_outlined, 'Tasks'),
      _navBarItem(Icons.person, 'Profile'),
      _navBarItem(Icons.settings, 'Settings'),
    ];

    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: bloc.screens[bloc.screenIndex],
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 5),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
            ),
          ],
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return SalomonBottomBar(
              currentIndex: bloc.screenIndex,
              onTap: (index) {
                bloc.add(
                  ChangeNavigationBarScreenEvent(index: index),
                );
              },
              // margin: const EdgeInsets.all(15),
              selectedItemColor: AppColors.accent,
              unselectedItemColor: AppColors.primary,
              curve: Curves.easeInOutCirc,
              duration: const Duration(milliseconds: 350),
              items: navBarItems,
            );
          },
        ),
      ),
    );
  }

  SalomonBottomBarItem _navBarItem(IconData icon, String title) {
    return SalomonBottomBarItem(
      icon: Icon(icon),
      title: Text(title),
    );
  }
}
