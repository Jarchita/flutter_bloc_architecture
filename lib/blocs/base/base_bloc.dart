import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports/constants.dart';
import '../../services/api/api_service.dart';
import '../../services/service_locator.dart';

part 'base_event.dart';
part 'base_state.dart';

/// Purpose : base bloc class extended by all blocs
class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(BaseState initialState) : super(initialState);
  final apiService = locator<ApiService>();
}
