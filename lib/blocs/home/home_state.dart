part of 'home_bloc.dart';

abstract class HomeState extends BaseState {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}
