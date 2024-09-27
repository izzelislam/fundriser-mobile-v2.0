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
