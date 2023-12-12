import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/data/models/series_model.dart';
import 'package:task_1/modules/card_body/card_deatils.dart';
import 'package:task_1/shared/cubit/cubit.dart';
import 'package:task_1/shared/cubit/states.dart';

class CardContnet extends StatelessWidget {
  final Results resultsModel;
  final int index;
  const CardContnet(
      {super.key, required this.resultsModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Started: ${resultsModel.startYear!}",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  "Ended: ${resultsModel.endYear!}",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  resultsModel.rating! == ""
                      ? "No Rating"
                      : resultsModel.rating!,
                  style: Theme.of(context).textTheme.displayMedium,
                )
              ],
            ),
            const SizedBox(height: 15),
            AppCubit.get(context).visibliatyList[index]
                ? CardDetails(
                    model: resultsModel,
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
