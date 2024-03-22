import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softeng_egghunt_admin/add_egg/infrastructure/add_egg_bloc.dart';
import 'package:softeng_egghunt_admin/repository/egghunt_repository_provider.dart';

class AddEggPage extends StatelessWidget {
  static const routeName = "/addEgg";

  const AddEggPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un oeuf"),
      ),
      body: BlocProvider(
        create: (_) => AddEggBloc(eggRepository: EggHuntRepositoryProvider.getEggsRepository()),
        child: _AddEggScreen(),
      ),
    );
  }
}

class _AddEggScreen extends StatefulWidget {
  @override
  State<_AddEggScreen> createState() => _AddEggScreenState();
}

class _AddEggScreenState extends State<_AddEggScreen> {
  final TextEditingController _eggNameController = TextEditingController();
  final TextEditingController _eggDescriptionController = TextEditingController();
  int _currentEggValue = 1;
  String? _errorMessage;

  @override
  void initState() {
    _eggNameController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AddEggBloc, AddEggState>(
      listener: (context, state) {
        switch (state) {
          case AddEggErrorState errorState:
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: const Text("Erreur !"),
                content: Text(errorState.errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text("Fermer"),
                  ),
                ],
              ),
            );
            setState(() {
              _errorMessage = errorState.errorMessage;
            });
            break;
          case AddEggSuccessState _:
            Navigator.pop(context);
            break;
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _eggNameController,
                decoration: InputDecoration(
                  labelText: "Nom technique de l'oeuf (obligatoire)",
                  hintText: "Exemple: dansLePanierDeBasket",
                  helperText: "1 caractère minimum, pas de max\nEviter les caractères spéciaux 🙄",
                  suffixIcon: InkWell(
                    onTap: () => _eggNameController.clear(),
                    child: const Icon(Icons.clear),
                  ),
                  errorText: _errorMessage,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _eggDescriptionController,
                decoration: InputDecoration(
                  labelText: "Description de l'oeuf, non visible (optionnel)",
                  hintText: "Exemple: Quelque part vers la borne de basketball",
                  helperText: "Pas de minimum ni maximum de caractères",
                  suffixIcon: InkWell(
                    onTap: () => _eggNameController.clear(),
                    child: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  const Text("Valeur de l'oeuf: "),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "$_currentEggValue",
                          style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(" point(s)", style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              Slider(
                value: _currentEggValue.toDouble(),
                min: 1,
                max: 10,
                onChanged: (newEggValue) {
                  setState(() {
                    _currentEggValue = newEggValue.toInt();
                  });
                },
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: _buildSubmitCallback(),
                child: const Text("Valider"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Function()? _buildSubmitCallback() {
    if (_eggNameController.value.text.isNotEmpty) {
      return () => context.read<AddEggBloc>().add(AddEggSubmitEvent(
            eggName: _eggNameController.text,
            eggDescription: _eggDescriptionController.text,
            eggValue: _currentEggValue,
          ));
    }
    return null;
  }
}
