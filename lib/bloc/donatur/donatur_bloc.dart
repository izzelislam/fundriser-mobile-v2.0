import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fundriser/model/donatur/donatur_data_model.dart';
import 'package:fundriser/model/donatur/donatur_detail_model.dart';
import 'package:fundriser/service/donatur_service.dart';

part 'donatur_event.dart';
part 'donatur_state.dart';

class DonaturBloc extends Bloc<DonaturEvent, DonaturState> {
  DonaturBloc() : super(DonaturInitial()) {
    on<GetAllDonatur>((event, emit) async {
      try {
        emit(DonaturLoading());
        final donatur = await DonaturService().getAllDonatur(page: event.page);
        emit(DonaturAllSuccess(data: donatur));
      } catch (e) {
        emit(DonaturFailed(message: e.toString()));
      }
    });

    on<FindDoatur>((event, emit) async {
      try {
        emit(DonaturLoading());
        final donatur = await DonaturService().findDonatur(event.uuid);
        emit(DonaturFindSuccess(data: donatur));
      } catch (e) {
        emit(DonaturFailed(message: e.toString()));
      }
    });

  }
}