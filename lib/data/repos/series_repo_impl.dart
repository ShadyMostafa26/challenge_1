import 'package:task_1/data/models/series_model.dart';
import 'package:task_1/data/repos/series._repo.dart';
import 'package:task_1/shared/helpers/constants.dart';
import 'package:task_1/shared/network/remote/dio_helper.dart';

class SeriesRepoImpl implements SeriesRepo {
  @override
  Future<void> getSeriresList(
      List<Results>? series, List<bool> visibliatyList, offset) async {
    await DioHelper.getData(
      url:
          "public/series?limit=15&offset=$offset&startYear=2022&ts=1&$apiKey&$hash",
    ).then((value) {
      series!.addAll((value.data['data']['results'] as List)
          .map((e) => Results.fromJson(e))
          .toList());

      for (int i = 0; i < series.length; i++) {
        visibliatyList.add(false);
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}
