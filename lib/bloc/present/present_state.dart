part of 'present_bloc.dart';

sealed class PresentState extends Equatable {
  const PresentState();
  
  @override
  List<Object> get props => [];
}

final class PresentInitial extends PresentState {}

final class PresentLoading extends PresentState {}

final class PresentAllSuccess extends PresentState {
  final List<PresentModel> presents;
  const PresentAllSuccess(this.presents);
  @override
  List<Object> get props => [presents];
}

final class PresentDetailSuccess extends PresentState {
  final PresentModel present;
  const PresentDetailSuccess(this.present);
  @override
  List<Object> get props => [present];
}

final class PresentSuccess extends PresentState {}

final class PresentCreateSuccess extends PresentState {
  final PresentModel present;
  const PresentCreateSuccess(this.present);
  @override
  List<Object> get props => [present];
}

final class PresentFailed extends PresentState {
  final String message;
  const PresentFailed(this.message);
  @override
  List<Object> get props => [message];
}

final class PresentDeleteSuccess extends PresentState {}



