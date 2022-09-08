import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafeltester/constants/tables.dart';
import 'package:tafeltester/cubit/question_cubit.dart';

import '../models/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final QuestionCubit questionCubit;
  Map<int, bool> currentTables = tables;

  SettingsCubit({required this.questionCubit})
      : super(NewSettings(Settings(tables: tables))) {
    currentTables = tables;
  }

  void updateTableSetting(int table, bool value) {
    currentTables[table] = value;
    emit(NewSettings(currentTables));
  }
}
