part of 'donatur_bloc.dart';

sealed class DonaturState extends Equatable {
  const DonaturState();
  
  @override
  List<Object> get props => [];
}

final class DonaturInitial extends DonaturState {}

class DonaturLoading extends DonaturState {}

class DonaturFailed extends DonaturState {
  final String message;

  const DonaturFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class DonaturFindSuccess extends DonaturState {
  final DonaturDetailModel data;

  const DonaturFindSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class DonaturAllSuccess extends DonaturState {
  final List<DonaturDataModel>? data;

  const DonaturAllSuccess({this.data});

  @override
  List<Object> get props => [data!];
}
