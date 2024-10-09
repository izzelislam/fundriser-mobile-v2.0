part of 'donatur_bloc.dart';

sealed class DonaturEvent extends Equatable {
  const DonaturEvent();

  @override
  List<Object> get props => [];
}

class GetAllDonatur extends DonaturEvent {
  final String page;

  const GetAllDonatur({this.page = '1'});

  @override
  List<Object> get props => [page];
}

class FindDoatur extends DonaturEvent {
  final String uuid;

  const FindDoatur({required this.uuid});

  @override
  List<Object> get props => [uuid];
}

class CreateDonatur extends DonaturEvent {
  final DonaturFormModel data;

  const CreateDonatur({required this.data});

  @override
  List<Object> get props => [data];
}

class UpdateDonatur extends DonaturEvent {
  final String uuid;
  final DonaturFormModel data;

  const UpdateDonatur({required this.uuid, required this.data});

  @override
  List<Object> get props => [uuid, data];
}

class DeleteDonatur extends DonaturEvent {
  final String uuid;

  const DeleteDonatur({required this.uuid});

  @override
  List<Object> get props => [uuid];
}
