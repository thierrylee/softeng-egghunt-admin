import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softeng_egghunt_admin/add_egg/add_egg_page.dart';
import 'package:softeng_egghunt_admin/data/egg.dart';
import 'package:softeng_egghunt_admin/egg_list/infrastructure/egg_list_bloc.dart';
import 'package:softeng_egghunt_admin/repository/egghunt_repository_provider.dart';
import 'package:softeng_egghunt_admin/show_egg/show_egg_page.dart';

class EggListPage extends StatelessWidget {
  static const String routeName = "/eggList";

  const EggListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oeufs"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_rounded),
            tooltip: "Ajouter un oeuf",
            onPressed: () {
              Navigator.of(context).pushNamed(AddEggPage.routeName);
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => EggListBloc(
          eggsRepository: EggHuntRepositoryProvider.getEggsRepository(),
        )..add(EggListInitEvent()),
        child: _ScoreListScreen(),
      ),
    );
  }
}

class _ScoreListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<EggListBloc, EggListState, EggListState>(
        selector: (state) => state,
        builder: (context, viewModel) => switch (viewModel) {
              EggListInitialState _ => const Center(child: CircularProgressIndicator()),
              EggListFetchedState state => _EggListView(eggs: state.eggs),
            });
  }
}

class _EggListView extends StatelessWidget {
  final List<Egg> eggs;

  const _EggListView({required this.eggs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: eggs.length,
      itemBuilder: (context, index) {
        return _EggItemWidget(egg: eggs[index]);
      },
      separatorBuilder: (_, index) => const Divider(height: 0),
    );
  }
}

class _EggItemWidget extends StatelessWidget {
  final Egg egg;

  const _EggItemWidget({required this.egg});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, ShowEggPage.buildRoute(egg.eggName))
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  egg.eggName,
                  style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  egg.eggDescription,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Text(
                    "${egg.eggValue}",
                    style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(" point(s)", style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
