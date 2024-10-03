part of 'permit_bloc.dart';

sealed class PermitState extends Equatable {
  const PermitState();
  
  @override
  List<Object> get props => [];
}

final class PermitInitial extends PermitState {}

final class PermitLoading extends PermitState {}

final class PermitAllSuccess extends PermitState {

  final List<PermitDataModel> permits;

  const PermitAllSuccess(this.permits);

  @override
  List<Object> get props => [permits];
}

final class PermitCreateSuccess extends PermitState {

  final PermitDataModel permit;

  const PermitCreateSuccess(this.permit);

  @override
  List<Object> get props => [permit];
}

final class PermitFindSucess extends PermitState {

  final PermitDataModel permit;

  const PermitFindSucess(this.permit);

  @override
  List<Object> get props => [permit];
}

final class PermitDeleteSuccess extends PermitState {

  final String message;

  const PermitDeleteSuccess(this.message);
  
  @override
  List<Object> get props => [message];
}

final class PermitFailed extends PermitState {

  final String message;

  const PermitFailed(this.message);

  @override
  List<Object> get props => [message];
}

