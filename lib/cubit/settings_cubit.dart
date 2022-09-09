import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tafeltester/constants/tables.dart';

import '../models/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  late Map<int, bool> currentTables = tables;

  SettingsCubit() : super(NewSettings(Settings(tables: tables))) {
    currentTables = tables;
    setTablesToPractice();
  }

  Future<void> setTablesToPractice() async {
    var savedTables = await Settings.getSavedTables();
    currentTables.forEach((key, value) {
      if (savedTables.contains(key)) {
        currentTables[key] = true;
      } else {
        currentTables[key] = false;
      }
    });
  }

  void updateTableSetting(int table) {
    currentTables[table] = !(currentTables[table] as bool);

    if (!currentTables.values.contains(true)) {
      currentTables.updateAll((key, value) => true);
    }

    if (kDebugMode) {
      print("New Settings: $currentTables");
    }

    List<int> arr = [];

    tables.forEach((key, value) {
      if (value) {
        arr.add(key);
      }
    });

    Settings.setSavedTables(arr);

    emit(NewSettings(Settings(tables: currentTables)));
  }
}
