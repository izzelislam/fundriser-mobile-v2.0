part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetProvince extends LocationEvent {}

class GetRegency extends LocationEvent {
  final String provinceId;

  const GetRegency(this.provinceId);

  @override
  List<Object> get props => [provinceId];
}

class GetDistrict extends LocationEvent {
  final String regencyId;

  const GetDistrict(this.regencyId);

  @override
  List<Object> get props => [regencyId];
}
