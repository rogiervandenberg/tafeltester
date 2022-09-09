import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/settings_cubit.dart';

class Configuration extends StatelessWidget {
  final SettingsCubit cubit;
  const Configuration({Key? key, required this.cubit}) : super(key: key);

  Widget buttonContents(int k) {
    return SizedBox(
      width: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            k.toString(),
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(
          Icons.settings,
          color: Color(0x8a000000),
        ),
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
              return Center(
                child: Column(
                  children: [
                    BlocBuilder<SettingsCubit, SettingsState>(
                      bloc: cubit,
                      builder: (context, state) {
                        return SizedBox(
                          child: Column(
                            children: [
                              Text(
                                "Kies je tafels",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Wrap(
                                children: [
                                  for (var k in state.settings.tables.keys)
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: state.settings.tables[k]!
                                          ? ElevatedButton(
                                              onPressed: () =>
                                                  cubit.updateTableSetting(k),
                                              style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                padding:
                                                    const EdgeInsets.all(18),
                                              ),
                                              child: buttonContents(k),
                                            )
                                          : OutlinedButton(
                                              onPressed: () =>
                                                  cubit.updateTableSetting(k),
                                              style: OutlinedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                padding:
                                                    const EdgeInsets.all(18),
                                                // primary: Colors.green
                                              ),
                                              child: buttonContents(k),
                                            ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
