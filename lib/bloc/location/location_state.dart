part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationFailed extends LocationState {
  final String message;

  const LocationFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class ProvinceSuccess extends LocationState {
  final List<ProvinceModel> data;

  const ProvinceSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class RegencySuccess extends LocationState {
  final List<RegencyModel> data;

  const RegencySuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class DistrictSuccess extends LocationState {
  final List<DistrictModel> data;

  const DistrictSuccess(this.data);

  @override
  List<Object> get props => [data];
}

