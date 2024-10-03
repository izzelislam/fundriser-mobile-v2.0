part of 'donation_bloc.dart';

sealed class DonationEvent extends Equatable {
  const DonationEvent();
  @override
  List<Object> get props => [];
}

class GetTotalDonation extends DonationEvent {}

class GetAllDonation extends DonationEvent {
  final String? page;

  const GetAllDonation({this.page = '1'});

  @override
  List<Object> get props => [page!];
}

class CreateDonation extends DonationEvent {
  final DonationFormModel data;

  const CreateDonation(this.data);

  @override
  List<Object> get props => [data];
}

class SearchDonation extends DonationEvent{
  final String q;

  const SearchDonation(this.q);

  @override
  List<Object> get props => [q];
}
