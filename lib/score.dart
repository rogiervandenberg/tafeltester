import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeltester/cubit/score_cubit.dart';

class Score extends StatelessWidget {
  Score({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: BlocBuilder<ScoreCubit, int>(
        builder: (context, state) {
          return Text('$state', style: textTheme.headline2);
        },
      ),
    );
  }
}
