import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/settings_cubit.dart';

class Configuration extends StatelessWidget {
  final SettingsCubit cubit;
  const Configuration({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          // when raised button is pressed
          // we display showModalBottomSheet
          showModalBottomSheet<void>(
            // context and builder are
            // required properties in this widget
            context: context,
            builder: (BuildContext context) {
              // we set up a container inside which
              // we create center column and display text

              // Returning SizedBox instead of a Container
              return SizedBox(
                height: 500,
                child: Center(
                  child: BlocBuilder<SettingsCubit, SettingsState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var k in state.settings.tables.keys)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () => context
                                      .read<SettingsCubit>()
                                      .updateTableSetting(k, true),
                                  child: SizedBox(
                                    width: 100.0,
                                    child: Center(
                                      child: Text(
                                        k.toString(),
                                        style: const TextStyle(fontSize: 72),
                                      ),
                                    ),
                                  )),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
