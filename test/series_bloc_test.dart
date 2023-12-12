import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_1/data/repos/series_repo_impl.dart';

class MockSeries extends SeriesRepoImpl with Mock {}

void main() {
  group('Series Cubit', () {
    test("test cubit", () {
      var seriesCubit = SeriesRepoImpl();
      seriesCubit.getSeriresList([], [], 0);
    });
  });
}
