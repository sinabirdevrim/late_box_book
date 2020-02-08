import 'package:get_it/get_it.dart';
import 'package:late_box_book/repository/user_repository.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';
import 'package:late_box_book/services/firebase_storage_service.dart';
import 'package:late_box_book/services/firestore_db_service.dart';
import 'package:late_box_book/services/notification_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => FirebaseStorageService());
}
