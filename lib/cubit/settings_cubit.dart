import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tafeltester/constants/tables.dart';

import '../models/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  late Map<int, bool> currentTables = tables;

  SettingsCubit() : super(NewSettings(Settings(tables: tables))) {
    currentTables = tables;
  }

  void updateTableSetting(int table) {
    currentTables[table] = !(currentTables[table] as bool);

    if (!currentTables.values.contains(true)) {
      currentTables.updateAll((key, value) => true);
    }

    if (kDebugMode) {
      print("New Settings: $currentTables");
    }

    emit(NewSettings(Settings(tables: currentTables)));
  }
}
