
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_app/common/navigation/router/routes.dart';
import 'package:my_app/models/Event.dart';
import 'package:my_app/common/utils/colors.dart' as constants;



class EventCard extends StatelessWidget {
  const EventCard({
    required this.event,
    this.imageURL,
    super.key,
  });

  final Event event;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          context.goNamed(
            AppRoute.event.name,
            params: {'id': event.id},
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5.0,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 500,
                  alignment: Alignment.center,
                  color: const Color(constants.primaryColorDark),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: event.eventImageUrl != null
                            ? Stack(children: [
                                const Center(
                                    child: CircularProgressIndicator()),
                                CachedNetworkImage(
                                  errorWidget: (context, url, dynamic error) =>
                                      const Icon(Icons.error_outline_outlined),
                                  imageUrl: event.eventImageUrl!,
                                  cacheKey: event.eventImageKey,
                                  width: double.maxFinite,
                                  height: 500,
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.fill,
                                ),
                              ])
                            : Image.asset(
                                'images/amplify.png',
                                fit: BoxFit.contain,
                              ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            event.location,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 8, 8, 4),
                child: DefaultTextStyle(
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          event.description,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.black54),
                        ),
                      ),
                      Text(
                        DateFormat('MMMM dd, yyyy')
                            .format(event.startDate.getDateTimeInUtc()),
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                          DateFormat('MMMM dd, yyyy')
                              .format(event.endDate.getDateTimeInUtc()),
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
