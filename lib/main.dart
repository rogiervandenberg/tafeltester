import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeltester/configuration.dart';
import 'package:tafeltester/cubit/question_cubit.dart';
import 'package:tafeltester/cubit/score_cubit.dart';
import 'package:tafeltester/cubit/settings_cubit.dart';
import 'package:tafeltester/score.dart';

import 'configuration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SettingsCubit>(
              lazy: false,
              create: (context) => SettingsCubit(),
            ),
            BlocProvider<QuestionCubit>(
              lazy: false,
              create: (context) => QuestionCubit(
                  settingsCubit: BlocProvider.of<SettingsCubit>(context)),
            ),
            BlocProvider<ScoreCubit>(
              lazy: false,
              create: (context) => ScoreCubit(
                  questionCubit: BlocProvider.of<QuestionCubit>(context)),
            ),
          ],
          child: BlocBuilder<QuestionCubit, QuestionState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Colors.purple[900],
                // appBar: AppBar(
                //   // Here we take the value from the MyHomePage object that was created by
                //   // the App.build method, and use it to set our appbar title.
                //   title: const Text("Tafels!"),
                // ),
                body: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Configuration(
                          cubit: BlocProvider.of<SettingsCubit>(context)),
                    ),
                    const Positioned(
                      top: 16.0,
                      right: 16.0,
                      child: Score(),
                    ),
                    Positioned(
                      bottom: 16.0,
                      right: 16.0,
                      child: TextButton(
                          onPressed: () =>
                              context.read<QuestionCubit>().start(),
                          child: const SizedBox(
                            width: 100.0,
                            child: Center(
                              child: Text(
                                "Begin opnieuw",
                              ),
                            ),
                          )),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Score(),
                          if (state is QuestionLoaded &&
                              state is! LastAnswerGiven)
                            Text(
                              state.assignment.toString(),
                              style: const TextStyle(fontSize: 96),
                            ),
                          if (state is QuestionInitial ||
                              state is LastAnswerGiven)
                            TextButton(
                                onPressed: () =>
                                    context.read<QuestionCubit>().start(),
                                child: const Text("Start")),
                          if (state is QuestionLoaded &&
                              state is! LastAnswerGiven)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (var i in state.assignment.multiplication
                                    .answerOptions())
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: () => context
                                            .read<QuestionCubit>()
                                            .giveAnswer(i),
                                        child: SizedBox(
                                          width: 100.0,
                                          child: Center(
                                            child: Text(
                                              i.toString(),
                                              style:
                                                  const TextStyle(fontSize: 72),
                                            ),
                                          ),
                                        )),
                                  ),
                              ],
                            ),

                          if (state is LastAnswerGiven) const Text("Klaar"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )

        // const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}
