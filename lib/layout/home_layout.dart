import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:task_1/data/models/series_model.dart';
import 'package:task_1/modules/card_body/card_content.dart';
import 'package:task_1/shared/cubit/cubit.dart';
import 'package:task_1/shared/cubit/states.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getMoviesList();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          AppCubit.get(context).isLoading = true;
        });
        AppCubit.get(context).offset += 15;
        AppCubit.get(context).getMoviesList();

        setState(() {
          AppCubit.get(context).isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: (AppCubit.get(context).series!.isNotEmpty)
              ? OfflineBuilder(
                  connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,
                  ) {
                    final bool connected =
                        connectivity != ConnectivityResult.none;
                    if (connected) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SafeArea(
                          child: Column(
                            children: [
                              TextField(
                                controller: searchController,
                                onChanged: (value) => AppCubit.get(context)
                                    .searchInList(value, context),
                                cursorColor: Colors.red[200],
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Search a series",
                                  hintStyle: const TextStyle(
                                    color: Colors.amber,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: ListView.separated(
                                  controller: scrollController,
                                  itemCount: AppCubit.get(context)
                                          .searchedList!
                                          .isEmpty
                                      ? AppCubit.get(context).series!.length
                                      : AppCubit.get(context)
                                          .searchedList!
                                          .length,
                                  itemBuilder: (context, index) {
                                    if (index >=
                                        AppCubit.get(context).series!.length -
                                            1) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.yellow,
                                        ),
                                      );
                                    } else {
                                      return buildCardItem(
                                        context,
                                        (AppCubit.get(context)
                                                .searchedList!
                                                .isEmpty)
                                            ? AppCubit.get(context)
                                                .series![index]
                                            : AppCubit.get(context)
                                                .searchedList![index],
                                        index,
                                      );
                                    }
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return buildNoInternet();
                    }
                  },
                  child: const Text(""),
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: Colors.yellow,
                )),
        );
      },
    );
  }

  Widget buildCardItem(context, Results results, index) => GestureDetector(
        onTap: () {
          AppCubit.get(context).showAndHide(index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            "${results.thumbnail!.path}",
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).scaffoldBackgroundColor,
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 50,
                          left: 50,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 10),
                              color: Colors.black.withOpacity(0.5),
                              child: Text(
                                maxLines: 1,
                                results.title!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CardContnet(
                        resultsModel: results,
                        index: index,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildNoInternet() => SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text("Cant Connect, plz Check WIFI"),
                Image.asset("assets/images/wifi.png"),
              ],
            ),
          ),
        ),
      );
}
