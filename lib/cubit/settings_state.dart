part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {
  final Settings settings;
  const SettingsState(this.settings);
}

class NewSettings extends SettingsState {
  const NewSettings(settings) : super(settings);
}
