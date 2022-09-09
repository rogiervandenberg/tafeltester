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
        // darkTheme: ThemeData.dark(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
          // textTheme: GoogleFonts.emilysCandyTextTheme(),
          scaffoldBackgroundColor: Colors.green[100],

          // Define the default font family.
          fontFamily: 'Bevan',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          // textTheme: const TextTheme(
          //   displayLarge:
          //       TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
          // ),
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
                // backgroundColor: Colors.purple[900],
                // appBar: AppBar(
                //   // Here we take the value from the MyHomePage object that was created by
                //   // the App.build method, and use it to set our appbar title.
                //   title: const Text("Tafels!"),
                // ),
                body: Stack(
                  children: [
                    const LinearProgressIndicator(
                      value: 0.5,
                      semanticsLabel: 'Linear progress indicator',
                      color: Colors.grey,
                    ),
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
                    if (state is QuestionLoaded)
                      Positioned(
                        bottom: 16.0,
                        right: 16.0,
                        child: TextButton(
                            onPressed: () =>
                                context.read<QuestionCubit>().start(),
                            child: const Center(
                              child: Text(
                                "Begin opnieuw",
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
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .apply(fontFamily: "Caveat"),
                            ),
                          if (state is QuestionInitial ||
                              state is LastAnswerGiven)
                            TextButton(
                                onPressed: () =>
                                    context.read<QuestionCubit>().start(),
                                child: const Text("Start")),
                          const SizedBox(
                            height: 20,
                          ),
                          if (state is QuestionLoaded &&
                              state is! LastAnswerGiven)
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (var i in state.assignment.multiplication
                                    .answerOptions())
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () => context
                                            .read<QuestionCubit>()
                                            .giveAnswer(i),
                                        child: SizedBox(
                                          width: 70.0,
                                          height: 70.0,
                                          child: Center(
                                            child: Text(
                                              i.toString(),
                                              style:
                                                  const TextStyle(fontSize: 36),
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
