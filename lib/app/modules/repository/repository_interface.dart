import 'package:app_bounties/app/modules/models/user/user.dart';

abstract class IRepository {
  Future<List<User>?> getAllUsers();
}
