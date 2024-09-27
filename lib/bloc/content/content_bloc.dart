import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fundriser/model/content_data_model.dart';
import 'package:fundriser/service/conten_service.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc() : super(ContentInitial()) {
    on<GetAllcontent>((event, emit) async {
      try {
        emit(ContentLoading());
        final content = await ContentService().getAllContent();
        emit(ContentSuccess(content));
      } catch (e) {
        emit(ContentFailed(e.toString()));
      }
    });
  }
}
