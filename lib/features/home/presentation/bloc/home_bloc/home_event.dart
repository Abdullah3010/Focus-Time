part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangeNavigationBarScreenEvent extends HomeEvent {
  final int index;

  const ChangeNavigationBarScreenEvent ({required this.index});

  @override
  List<Object> get props => [index];
}
