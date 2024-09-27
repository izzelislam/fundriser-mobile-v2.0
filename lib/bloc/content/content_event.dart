part of 'content_bloc.dart';

sealed class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object> get props => [];
}

class GetAllcontent extends ContentEvent {}
