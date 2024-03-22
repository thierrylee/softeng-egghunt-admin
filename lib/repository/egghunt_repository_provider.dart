import 'package:get_it/get_it.dart';
import 'package:softeng_egghunt_admin/repository/eggs_repository.dart';

abstract class EggHuntRepositoryProvider {
  static const _useMock = true;

  static EggsRepository getEggsRepository() {
    if (GetIt.instance.isRegistered<EggsRepository>()) {
      return GetIt.instance.get<EggsRepository>();
    }

    final repository = switch (_useMock) {
      true => EggsRepositoryMock(),
      false => EggsRepositoryImpl(),
    };
    GetIt.instance.registerSingleton<EggsRepository>(repository);
    return repository;
  }
}
