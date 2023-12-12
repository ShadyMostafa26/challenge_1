import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/data/models/series_model.dart';
import 'package:task_1/data/repos/series_repo_impl.dart';
import 'package:task_1/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  SeriesRepoImpl? seriesRepoImpl;
  AppCubit({this.seriesRepoImpl}) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int offset = 0;
  List<bool> visibliatyList = [];
  List<Results>? series = [];

  Future<void> getMoviesList() async {
    emit(GetDataLoadingState());
    seriesRepoImpl!
        .getSeriresList(series, visibliatyList, offset)
        .then((value) {
      emit(GetDataSuccessState());
    }).catchError((error) {
      emit(GetDataErrorState());
    });
  }

  List<dynamic>? searchedList = [];

  void searchInList(String enteredWord, context) {
    List<dynamic> results = [];
    if (enteredWord.isEmpty) {
      results = series!;
    } else {
      results = series!
          .where((element) =>
              element.title!.toLowerCase().contains(enteredWord.toLowerCase()))
          .toList();
    }

    searchedList = results;
    emit(ChangeSearchState());
  }

  void showAndHide(int index) {
    visibliatyList[index] = !visibliatyList[index];
    emit(ChangeVisibiltyState());
  }
}

 /*
 SeriesModel? seriesModel;
  Future<void> getData(context) async {
    emit(GetDataLoadingState());
    await DioHelper.getData(
      url:
          "public/series?limit=15&offset=$offset&startYear=2022&ts=1&$apiKey&$hash",
    ).then((value) {
      seriesModel = SeriesModel.fromJson(value.data);
      for (int i = 0; i < seriesModel!.data!.results!.length; i++) {
        visibliatyList.add(false);
      }

      emit(GetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataErrorState());
    });
  }


    void onScroll(context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoading = true;
        offset += 15;
      
      }
    });
    isLoading = false;
    emit(GetDataErrorState());
  }
}



 */
 
