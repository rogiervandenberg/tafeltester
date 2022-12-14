import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeltester/configuration.dart';
import 'package:tafeltester/cubit/question_cubit.dart';
import 'package:tafeltester/cubit/score_cubit.dart';
import 'package:tafeltester/cubit/settings_cubit.dart';
import 'package:tafeltester/cubit/timer_cubit.dart';
import 'package:tafeltester/score.dart';

import 'package:animate_do/animate_do.dart';
import 'package:tafeltester/timer.dart';

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
        title: 'Tafel tester',
        // darkTheme: ThemeData.dark(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
          // textTheme: GoogleFonts.emilysCandyTextTheme(),
          scaffoldBackgroundColor: Colors.green[100],

          // Define the default font family.
          fontFamily: 'Bevan',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 16.0),
            displayLarge:
                TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
          ),
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
            BlocProvider<TimerCubit>(
              lazy: false,
              create: (context) => TimerCubit(
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
                body: SafeArea(
                  child: Stack(
                    children: [
                      if (state is QuestionLoaded && state is! LastAnswerGiven)
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          tween: Tween<double>(
                            begin: 0,
                            end: state.assignment.progress,
                          ),
                          builder: (context, value, _) =>
                              LinearProgressIndicator(
                            minHeight: 8.0,
                            value: value,
                            color: Colors.grey,
                          ),
                        ),
                      // LinearProgressIndicator(
                      //   minHeight: 8.0,
                      //   value: state.assignment.progress,
                      //   color: Colors.grey,
                      // ),
                      Positioned(
                        top: 24.0,
                        left: 16.0,
                        child: Configuration(
                            cubit: BlocProvider.of<SettingsCubit>(context)),
                      ),
                      if (state is QuestionLoaded)
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
                      if (state is QuestionLoaded)
                        const Positioned(
                          bottom: 0,
                          left: 16.0,
                          child: Timer(),
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
                            if (state is QuestionInitial)
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "Met deze app kun je je tafels heel gemakkelijk oefenen. Stel linksboven bij het tandwiel in welke tafels je precies wilt, of begin direct:",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () =>
                                          context.read<QuestionCubit>().start(),
                                      child: const SizedBox(
                                        width: 100.0,
                                        height: 84.0,
                                        child: Center(
                                          child: Text(
                                            "Start",
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
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
                                            width: 68.0,
                                            height: 76.0,
                                            child: Center(
                                              child: Text(
                                                i.toString(),
                                                style: const TextStyle(
                                                    fontSize: 32),
                                              ),
                                            ),
                                          )),
                                    ),
                                ],
                              ),

                            if (state is LastAnswerGiven)
                              ElasticIn(
                                duration: const Duration(milliseconds: 800),
                                delay: const Duration(milliseconds: 200),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Klaar!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Goed bezig! Zojuist heb je ${state.assignment.totalAmount} tafelsommen gedaan! Blijf zo oefenen!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )

        // const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}
