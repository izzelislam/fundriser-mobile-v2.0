
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fundriser/model/donation_data_model.dart';
import 'package:fundriser/model/total_donation_model.dart';
import 'package:fundriser/service/donation_service.dart';

part 'donation_event.dart';
part 'donation_state.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  DonationBloc() : super(DonationInitial()) {
    on<GetTotalDonation>((event, emit) async {
      try {
        emit(DonationLoading());
        final res = await DonationService().getTotalDOnation();
        emit(DonationTotalSuccess(res));
      } catch (e) {
        emit(DonationFailed(e.toString()));
      }
    });

    on<GetAllDonation>((event, emit) async {
      try {
        emit(DonationLoading());
        final res = await DonationService().getAllDonation(page: event.page!);
        emit(DonationAllSuccess(res));
      } catch (e) {
        emit(DonationFailed(e.toString()));
      }
    });
  }
}
