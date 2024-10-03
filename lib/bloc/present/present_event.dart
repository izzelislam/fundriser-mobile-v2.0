part of 'present_bloc.dart';

sealed class PresentEvent extends Equatable {
  const PresentEvent();

  @override
  List<Object> get props => [];
}

class GetAllPresent extends PresentEvent {}

class FindPresent extends PresentEvent {
  final String id;
  const FindPresent(this.id);

  @override
  List<Object> get props => [id];
}

class CreatePresent extends PresentEvent {
  final PresentFormModel present;
  const CreatePresent(this.present);

  @override
  List<Object> get props => [present];
}

class DeletePresent extends PresentEvent {
  final String id;
  const DeletePresent(this.id);

  @override
  List<Object> get props => [id];
}


