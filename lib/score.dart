import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeltester/cubit/score_cubit.dart';

class Score extends StatelessWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: BlocBuilder<ScoreCubit, int>(
        builder: (context, state) {
          return ElasticIn(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: Text('Score: $state', style: textTheme.headline2));
        },
      ),
    );
  }
}
