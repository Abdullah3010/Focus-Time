import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_time/core/network/network_info.dart';
import 'package:focus_time/features/auth/data/datasources/auth_local_date_source.dart';
import 'package:focus_time/features/auth/data/datasources/auth_remote_date_source.dart';
import 'package:focus_time/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:focus_time/features/auth/domain/repositories/auth_repository.dart';
import 'package:focus_time/features/auth/domain/usecases/login.dart';
import 'package:focus_time/features/auth/domain/usecases/logout.dart';
import 'package:focus_time/features/auth/domain/usecases/sign_in.dart';
import 'package:focus_time/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:focus_time/features/profile/data/datasources/profile_local_date_source.dart';
import 'package:focus_time/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:focus_time/features/profile/data/repositories/profile_repository_imp.dart';
import 'package:focus_time/features/profile/domain/repositories/profile_repository.dart';
import 'package:focus_time/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:focus_time/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:focus_time/features/tasks/data/datasources/task_local_date_source.dart';
import 'package:focus_time/features/tasks/data/datasources/task_remote_date_source.dart';
import 'package:focus_time/features/tasks/data/repositories/tasks_repository_imp.dart';
import 'package:focus_time/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:focus_time/features/tasks/domain/usecases/add_task.dart';
import 'package:focus_time/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:focus_time/features/tasks/domain/usecases/update_task.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MyInjector {
  static final injector = GetIt.instance;

  static Future<void> init() async {
//! Features - auth

// Bloc

    injector.registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUsecase: injector(),
        logoutUsecase: injector(),
        signInUsecase: injector(),
      ),
    );

// Usecases

    injector.registerLazySingleton(() => LoginUsecase(injector()));
    injector.registerLazySingleton(() => LogoutUsecase(injector()));
    injector.registerLazySingleton(() => SignInUsecase(injector()));

// Repository

    injector.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(
        authLocalDateSource: injector(),
        authRemoteDateSource: injector(),
        networkInfo: injector()));

// Datasources

    injector.registerLazySingleton<AuthRemoteDateSource>(
      () => AuthRemoteImpWithFirebase(
        firestore: injector(),
        auth: injector(),
      ),
    );
    injector.registerLazySingleton<AuthLocalDateSource>(
        () => AuthLocalImpWithSqflite());

//! Features - tasks

// Bloc

    injector.registerFactory<TaskUsecasesBloc>(
      () => TaskUsecasesBloc(
        addTaskUsecase: injector(),
        getAllTasksUsecase: injector(),
        updateTaskUsecase: injector(),
      ),
    );

// Usecases

    injector.registerLazySingleton(() => AddTaskUsecase(injector()));
    injector.registerLazySingleton(() => GetAllTasksUsecase(injector()));
    injector.registerLazySingleton(() => UpdateTaskUsecase(injector()));

// Repository

    injector.registerLazySingleton<TasksRepository>(() => TasksRepositoryImp(
        taskLocalDateSource: injector(),
        taskRemoteDateSource: injector(),
        networkInfo: injector()));

// Datasources

    injector.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteImpWithFirebase(
        firestore: injector(),
      ),
    );
    injector.registerLazySingleton<TaskLocalDataSource>(
        () => TaskLocalImpWithSqflite());
//! Features - profile

// Bloc

    injector.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        updateUserUseCase: injector(),
      ),
    );

// Usecases

    injector.registerLazySingleton(() => UpdateUserUseCase(injector()));

// Repository

    injector.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImp(
        localDataSource: injector(),
        remoteDataSource: injector(),
      ),
    );

// Datasources

    injector.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteWithFirebase(
        firestore: injector(),
      ),
    );
    injector.registerLazySingleton<ProfileLocalDataSource>(
        () => ProfileLocalWithSqflite());
//!Core

    injector
        .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injector()));

//! External
    injector.registerLazySingleton(() => FirebaseAuth.instance);
    injector.registerLazySingleton(() => FirebaseFirestore.instance);
    injector.registerLazySingleton(() => InternetConnectionChecker());
  }
}
