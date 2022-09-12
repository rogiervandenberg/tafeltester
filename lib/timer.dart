import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeltester/cubit/timer_cubit.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          String strDigits(int n) => n.toString().padLeft(2, '0');
          // final days = strDigits(state.duration.inDays);
          // // Step 7
          // final hours = strDigits(state.duration.inHours.remainder(24));
          final minutes = strDigits(state.duration.inMinutes.remainder(60));
          final seconds = strDigits(state.duration.inSeconds.remainder(60));

          return ElasticIn(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: Text('$minutes:$seconds', style: textTheme.displaySmall));
        },
      ),
    );
  }
}
