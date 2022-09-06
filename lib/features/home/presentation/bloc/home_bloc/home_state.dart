part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ChangeNavigationBarScreenState extends HomeState {

  const ChangeNavigationBarScreenState();
  @override
  List<Object> get props => [];
}
