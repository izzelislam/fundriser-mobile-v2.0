part of 'donation_bloc.dart';

sealed class DonationState extends Equatable {
  const DonationState();
  
  @override
  List<Object> get props => [];
}

final class DonationInitial extends DonationState {}

class DonationLoading extends DonationState {}

class DonationFailed extends DonationState {
  final String message;

  const DonationFailed(this.message);

  @override
  List<Object> get props => [message];
}

class DonationTotalSuccess extends DonationState {
  final TotalDonationModel totalDonation;

  const DonationTotalSuccess(this.totalDonation);

  @override
  List<Object> get props => [totalDonation];
}

class DonationAllSuccess extends DonationState {
  final List<DonationDataModel> data;

  const DonationAllSuccess(this.data);

  @override
  List<Object> get props => ['data'];
}

class DonationSuccess extends DonationState {
  final DonationDataModel data;

  const DonationSuccess(this.data);

  @override
  List<Object> get props => [data];
}


