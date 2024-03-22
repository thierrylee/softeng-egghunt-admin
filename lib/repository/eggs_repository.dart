import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softeng_egghunt_admin/data/egg.dart';
import 'package:softeng_egghunt_admin/egg_list/infrastructure/egg_list_bloc.dart';

abstract class EggsRepository {
  Future<void> listenOnEggs(EggListBloc listener);

  Future<Iterable<Egg>> getEggs();

  Future<void> addEgg(Egg egg);
}

class EggsRepositoryImpl extends EggsRepository {
  EggsRepositoryImpl();

  Iterable<Egg>? _eggList;

  @override
  Future<void> listenOnEggs(EggListBloc listener) async {
    FirebaseFirestore.instance.collection("eggs").snapshots().listen((snapshot) {
      _eggList = _toEggList(snapshot.docs);
      listener.add(EggListUpdateEvent(eggs: _eggList!));
    });
  }

  @override
  Future<Iterable<Egg>> getEggs() async {
    return _eggList ?? {};
  }

  @override
  Future<void> addEgg(Egg egg) async {
    await FirebaseFirestore.instance.collection("eggs").add({
      "eggName": egg.eggName,
      "eggDescription": egg.eggDescription,
      "eggValue": egg.eggValue,
    });
  }

  Iterable<Egg> _toEggList(List<DocumentSnapshot<Map<String, dynamic>>> documents) {
    return documents.map((document) {
      if (document.data() == null) return null;
      final eggName = document.data()!["eggName"] as String?;
      final eggValue = document.data()!["eggValue"] as int?;
      final eggDescription = document.data()!["eggDescription"] as String?;
      if (eggName != null && eggValue != null) {
        return Egg(
          eggName: eggName,
          eggValue: eggValue,
          eggDescription: eggDescription ?? "Pas de description pour cet oeuf",
        );
      } else {
        return null;
      }
    }).whereType<Egg>();
  }
}

class EggsRepositoryMock extends EggsRepository {
  EggsRepositoryMock();

  Iterable<Egg>? _eggList;
  EggListBloc? _listener;

  @override
  Future<void> listenOnEggs(EggListBloc listener) async {
    _listener = listener;
    listener.add(EggListUpdateEvent(eggs: await getEggs()));
  }

  @override
  Future<Iterable<Egg>> getEggs() async {
    _eggList ??= {
      const Egg(eggName: "testEgg", eggValue: 1, eggDescription: "Un oeuf de test"),
      const Egg(eggName: "mainStage", eggValue: 1, eggDescription: "Sur la scène"),
      const Egg(eggName: "babyfootFoot", eggValue: 1, eggDescription: "Sur le babyfoot"),
      const Egg(eggName: "speakerThisDay", eggValue: 3, eggDescription: "Récompense pour avoir donné un talk"),
    };
    return _eggList!;
  }

  @override
  Future<void> addEgg(Egg egg) async {
    if (_eggList != null) {
      final newList = _eggList!.toList(growable: true);
      newList.add(egg);
      _eggList = newList;
      if (_listener != null) {
        listenOnEggs(_listener!);
      }
    }
  }
}
