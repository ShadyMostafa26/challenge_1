import 'package:task_1/data/models/series_model.dart';

abstract class SeriesRepo {
  Future<void> getSeriresList(
      List<Results>? series, List<bool> visibliatyList, int offset);
}
