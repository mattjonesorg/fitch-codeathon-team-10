import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_app/features/family_days/data/events_repository.dart';
import 'package:my_app/models/Event.dart';

final eventsListControllerProvider = Provider<EventsListController>((ref) {
  return EventsListController(ref);
});

class EventsListController {
  EventsListController(this.ref);
  final Ref ref;

  Future<void> add({
    required String location,
    required String startDate,
    required String endDate,
    required String description,
  }) async {
    Event event = Event(
      location: location,
      startDate: TemporalDateTime(DateTime.parse(startDate)),
      endDate: TemporalDateTime(DateTime.parse(endDate)),
      description: description,
    );

    final eventsRepository = ref.read(eventsRepositoryProvider);

    await eventsRepository.add(event);
  }
}
