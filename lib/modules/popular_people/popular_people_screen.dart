import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibtikar_task/modules/people_details/people_details_screen.dart';
import 'package:ibtikar_task/modules/popular_people/widgets/popular_people_list_item.dart';
import 'package:ibtikar_task/shared/components/conditional_builder.dart';
import 'package:ibtikar_task/shared/components/load_more.dart';
import 'package:ibtikar_task/shared/components/loading_progress.dart';
import 'package:ibtikar_task/shared/di/di.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class PopularPeopleScreen extends StatelessWidget {
  const PopularPeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Popular People'),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return di<PopularPeopleCubit>()..getPopularPeople();
        },
        child: BlocBuilder<PopularPeopleCubit, PopularPeopleStates>(
          builder: (BuildContext context, PopularPeopleStates state) {
            final cubit = PopularPeopleCubit.get(context);
            return RefreshIndicator(
              onRefresh: () => cubit.refresh(),
              child: LoadingProgress(
                show: state is LoadingPopularPeopleState,
                child: ConditionalBuilder(
                  condition: state is ErrorPopularPeopleState,
                  builder: (context) => const Center(
                    child: Text('Something went wrong, please try again'),
                  ),
                  fallback: (context) {
                    final response = cubit.popularPeopleResponse;
                    return LoadMore(
                      isFinish: response!.results!.length < 20,
                      onLoadMore: () async {
                        await cubit.getPopularPeople();
                        if (state is LoadingMorePopularPeopleState) {
                          return false;
                        }
                        return true;
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          final person = cubit.popularPeopleFeed[index];
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PeopleDetailsScreen(
                                    person: person,
                                  ),
                                ),
                              );
                            },
                            child: PopularPeopleListItem(
                              peopleItemModel: person,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: cubit.popularPeopleFeed.length,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
