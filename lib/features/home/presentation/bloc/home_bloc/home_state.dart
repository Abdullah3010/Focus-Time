part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ChangeNavigationBarScreenState extends HomeState {
  final int pageIndex;
  const ChangeNavigationBarScreenState(this.pageIndex);
  @override
  List<Object> get props => [pageIndex];
}
