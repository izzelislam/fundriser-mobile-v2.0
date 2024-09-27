part of 'content_bloc.dart';

sealed class ContentState extends Equatable {
  const ContentState();
  
  @override
  List<Object> get props => [];
}

final class ContentInitial extends ContentState {}

final class ContentLoading extends ContentState {}

final class ContentSuccess extends ContentState {
  final List<ContentDataModel> contents;

  const ContentSuccess(this.contents);

  @override
  List<Object> get props => [contents];
}

final class ContentFailed extends ContentState {
  final String message;

  const ContentFailed(this.message);

  @override
  List<Object> get props => [message];
}
