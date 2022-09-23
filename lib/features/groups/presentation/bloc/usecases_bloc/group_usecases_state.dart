part of 'group_usecases_bloc.dart';

abstract class GroupUsecasesState extends Equatable {
  const GroupUsecasesState();
  
  @override
  List<Object> get props => [];
}

class GroupUsecasesInitial extends GroupUsecasesState {}

class GroupUsecasesLoading extends GroupUsecasesState {}

class GroupUsecasesSuccess extends GroupUsecasesState {}

class GroupUsecasesError extends GroupUsecasesState {
}