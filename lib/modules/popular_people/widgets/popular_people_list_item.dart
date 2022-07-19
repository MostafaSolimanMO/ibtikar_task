import 'package:flutter/material.dart';
import 'package:ibtikar_task/modules/popular_people/model/popular_people_item_model.dart';
import 'package:ibtikar_task/shared/components/cached_image.dart';

class PopularPeopleListItem extends StatelessWidget {
  const PopularPeopleListItem({
    Key? key,
    required this.peopleItemModel,
  }) : super(key: key);

  final PopularPeopleItemModel peopleItemModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedImage(
          imageUrl: peopleItemModel.profilePath!,
          height: 42,
          width: 42,
          radius: 25,
        ),
        const SizedBox(
         width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              peopleItemModel.name!,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              peopleItemModel.knownForDepartment!,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
        const Spacer(),
        Text(
          'Popularity: ${peopleItemModel.popularity!.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
