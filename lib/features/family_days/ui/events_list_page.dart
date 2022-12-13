import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_app/features/family_days/data/events_repository.dart';
import 'package:my_app/common/utils/colors.dart' as constants;
import 'package:my_app/features/family_days/ui/add_event_bottomsheet.dart';
import 'package:my_app/features/family_days/ui/event_card.dart';


class EventsListPage extends HookConsumerWidget {
  const EventsListPage({
    super.key,
  });

  void showAddEventDialog(BuildContext context) async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (BuildContext context) {
        return AddEventBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final eventsListValue = ref.watch(eventsListStreamProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
           'Amplify Events Planner',
          ),
          backgroundColor: const Color(constants.primaryColorDark),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddEventDialog(context);
          },
          backgroundColor: const Color(constants.primaryColorDark),
          child: const Icon(Icons.add),
        ),
        body: eventsListValue.when(
            data: (events) => events.isEmpty
                ? const Center(
                    child: Text('No Events'),
                  )
                : Column(
                    children: [
                      Flexible(
                        child: GridView.count(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 3,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          padding: const EdgeInsets.all(4),
                          childAspectRatio:
                              (orientation == Orientation.portrait) ? 0.9 : 1.4,
                          children: events.map((eventData) {
                            return EventCard(event: eventData!);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
            error: (e, st) => const Center(
                  child: Text('Error'),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
