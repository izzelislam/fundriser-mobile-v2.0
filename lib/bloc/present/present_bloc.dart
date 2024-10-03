import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fundriser/model/present/present_form_model.dart';
import 'package:fundriser/model/present/present_model.dart';
import 'package:fundriser/service/present_service.dart';

part 'present_event.dart';
part 'present_state.dart';

class PresentBloc extends Bloc<PresentEvent, PresentState> {
  PresentBloc() : super(PresentInitial()) {
    on<GetAllPresent>((event, emit) async {
      try {
        emit(PresentLoading());
        final res = await PresentService().getPresent();
        emit(PresentAllSuccess(res));
      } catch (e) {
        emit(PresentFailed(e.toString()));
      }
    });

    on<CreatePresent>((event, emit) async {
      try {
        emit(PresentLoading());
        final res = await PresentService().createPresent(event.present);
        emit(PresentCreateSuccess(res));
      } catch (e) {
        emit(PresentFailed(e.toString()));
      }
    });

    on<DeletePresent>((event, emit) async {
      try {
        // emit(PresentLoading());
        await PresentService().deletePresent(event.id);
        emit(PresentDeleteSuccess());
      } catch (e) {
        emit(PresentFailed(e.toString()));
      }
    });

    on<FindPresent>((event, emit) async {
      try {
        emit(PresentLoading());
        final res = await PresentService().findPresent(event.id);
        emit(PresentDetailSuccess(res));
      } catch (e) {
        emit(PresentFailed(e.toString()));
      }
    });
  }

}
