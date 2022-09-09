import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:tafeltester/constants/tables.dart';
import 'package:tafeltester/cubit/question_cubit.dart';

import '../models/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final QuestionCubit questionCubit;
  late Map<int, bool> currentTables = tables;

  SettingsCubit({required this.questionCubit})
      : super(NewSettings(Settings(tables: tables))) {
    currentTables = tables;
  }

  void updateTableSetting(int table) {
    currentTables[table] = !(currentTables[table] as bool);

    if (kDebugMode) {
      print("New Settings: $currentTables");
    }
    emit(NewSettings(Settings(tables: currentTables)));
  }
}
