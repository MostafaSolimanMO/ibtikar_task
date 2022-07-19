import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibtikar_task/modules/popular_people/model/popular_people_item_model.dart';
import 'package:ibtikar_task/shared/components/cached_image.dart';
import 'package:ibtikar_task/shared/components/conditional_builder.dart';
import 'package:ibtikar_task/shared/components/image_downloader.dart';
import 'package:ibtikar_task/shared/di/di.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class PeopleDetailsScreen extends StatelessWidget {
  const PeopleDetailsScreen({
    Key? key,
    required this.person,
  }) : super(key: key);

  final PopularPeopleItemModel person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(person.name!),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDownloader(
                    imageUrl: person.profilePath!,
                    title: person.name,
                  ),
                ),
              );
            },
            child: Hero(
              tag:  person.profilePath!,
              child: CachedImage(
                imageUrl: person.profilePath!,
                height: 260,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Known For',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    person.knownForDepartment!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Gender',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    person.gender! == 0 ? 'Male' : 'Female',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          BlocProvider(
            create: (BuildContext context) {
              return di<PeopleDetailsCubit>()
                ..getPersonImages(personId: person.id!);
            },
            child: BlocBuilder<PeopleDetailsCubit, PeopleDetailsStates>(
              builder: (BuildContext context, PeopleDetailsStates state) {
                final cubit = PeopleDetailsCubit.get(context);
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Images',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        const Spacer(),
                        ConditionalBuilder(
                          condition: state is LoadingPeopleDetailsState,
                          builder: (context) {
                            return const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ConditionalBuilder(
                      condition: state is ErrorPeopleDetailsState,
                      builder: (context) => const Center(
                        child: Text('Something went wrong, please try again'),
                      ),
                      fallback: (context) => ConditionalBuilder(
                        condition: state is SuccessPeopleDetailsState,
                        builder: (context) => GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            final image = cubit.personImages[index + 1];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageDownloader(
                                      imageUrl: image.filePath!,
                                      title: person.name,
                                    ),
                                  ),
                                );
                              },
                              child: CachedImage(
                                imageUrl: image.filePath!,
                                height: 200,
                              ),
                            );
                          },
                          itemCount: cubit.personImages.length - 1,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
