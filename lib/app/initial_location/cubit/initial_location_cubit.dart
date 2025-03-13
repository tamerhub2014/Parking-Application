import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

part 'initial_location_state.dart';

class InitialLocationCubit extends Cubit<InitialLocationState> {
  InitialLocationCubit() : super(InitialLocationInitial());
}
