import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fundriser/model/location/district_model.dart';
import 'package:fundriser/model/location/province_model.dart';
import 'package:fundriser/model/location/regency_model.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
