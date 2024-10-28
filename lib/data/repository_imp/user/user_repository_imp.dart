import 'package:example_flutter_app/domain/entities/user/user_entity.dart';
import 'package:example_flutter_app/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepositoryImp implements UserRepository {
  @override
  Future<UserEntity> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
