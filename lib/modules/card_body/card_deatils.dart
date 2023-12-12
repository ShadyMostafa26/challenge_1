import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/data/models/series_model.dart';
import 'package:task_1/shared/cubit/cubit.dart';
import 'package:task_1/shared/cubit/states.dart';

class CardDetails extends StatelessWidget {
  final Results model;
  const CardDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (model.description != null)
            ? DefaultTextStyle(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  shadows: [
                    const Shadow(
                      blurRadius: 7,
                      color: Colors.amber,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      speed: const Duration(
                        milliseconds: 60,
                      ),
                      model.description!,
                    ),
                  ],
                ),
              )
            : DefaultTextStyle(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  shadows: [
                    const Shadow(
                      blurRadius: 7,
                      color: Colors.amber,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      speed: const Duration(
                        milliseconds: 20,
                      ),
                      "No Deatils",
                    ),
                  ],
                ),
              );
      },
    );
  }
}
