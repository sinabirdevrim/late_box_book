import 'package:get_it/get_it.dart';
import 'package:late_box_book/repository/user_repository.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';
import 'package:late_box_book/services/firestore_db_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDBService());
}
