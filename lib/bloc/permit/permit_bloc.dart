import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fundriser/model/permit/permit_data_model.dart';
import 'package:fundriser/model/permit/permit_form_model.dart';
import 'package:fundriser/service/permit_service.dart';

part 'permit_event.dart';
part 'permit_state.dart';

class PermitBloc extends Bloc<PermitEvent, PermitState> {
  PermitBloc() : super(PermitInitial()) {
    on<GetAllPermit>((event, emit) async {
      try {
        emit(PermitLoading());
        final data = await PermitService().getAllPermit();
        emit(PermitAllSuccess(data));
      } catch (e) {
        emit(PermitFailed(e.toString()));
      }
    });

    on<FindPermit>((event, emit) async {
      try {
        emit(PermitLoading());
        final data = await PermitService().findPermit(event.uuid);
        emit(PermitFindSucess(data));
      } catch (e) {
        emit(PermitFailed(e.toString()));
      }
    });

    on<CreatePermit>((event, emit) async {
      try {
        emit(PermitLoading());
        final data = await PermitService().createPermit(event.data);
        emit(PermitCreateSuccess(data));
      } catch (e) {
        emit(PermitFailed(e.toString()));
      }
  });

    on<DeletePermit>((event, emit) async {
      try {
        emit(PermitLoading());
        final data = await PermitService().deletePermit(event.uuid);
        emit(PermitDeleteSuccess(data));
      } catch (e) {
        emit(PermitFailed(e.toString()));
      }
    });
  }
}
