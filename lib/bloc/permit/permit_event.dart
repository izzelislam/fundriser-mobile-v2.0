part of 'permit_bloc.dart';

sealed class PermitEvent extends Equatable {
  const PermitEvent();

  @override
  List<Object> get props => [];
}

class GetAllPermit extends PermitEvent {}

class CreatePermit extends PermitEvent {
  final PermitFormModel data;

  const CreatePermit(this.data);

  @override
  List<Object> get props => [data];
}

class FindPermit extends PermitEvent {
  final String uuid;

  const FindPermit(this.uuid);

  @override
  List<Object> get props => [uuid];
}


class DeletePermit extends PermitEvent {
  final String uuid;

  const DeletePermit(this.uuid);

  @override
  List<Object> get props => [uuid];
}

