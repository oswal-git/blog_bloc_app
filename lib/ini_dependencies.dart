// import 'package:blog_bloc_app/core/common/cubits/cubit/app_user_cubit.dart';
// import 'package:blog_bloc_app/core/network/connection_checker.dart';
// import 'package:blog_bloc_app/core/secrets/app_secrets.dart';
// import 'package:blog_bloc_app/features/auth/data/datasources/auth_remote_data_source.dart';
// import 'package:blog_bloc_app/features/auth/data/repositories/auth_repository_impl.dart';
// import 'package:blog_bloc_app/features/auth/domain/repository/auth_repository.dart';
// import 'package:blog_bloc_app/features/auth/domain/usecases/current_user_usecase.dart';
// import 'package:blog_bloc_app/features/auth/domain/usecases/user_login_usecase.dart';
// import 'package:blog_bloc_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
// import 'package:blog_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:blog_bloc_app/features/blog/data/datasources/blog_local_data_source.dart';
// import 'package:blog_bloc_app/features/blog/data/datasources/blog_remote_data_source.dart';
// import 'package:blog_bloc_app/features/blog/data/repositories/blog_repository_impl.dart';
// import 'package:blog_bloc_app/features/blog/domain/repository/blog_repository.dart';
// import 'package:blog_bloc_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
// import 'package:blog_bloc_app/features/blog/domain/usecases/upload_blog_usecase.dart';
// import 'package:blog_bloc_app/features/blog/presentation/bloc/blog_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive/hive.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:blog_bloc_app/ini_dependencies_rel.dart';

final serviceLocator = GetIt.instance;

Future<void> iniDependences() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(url: AppSecrets.supabaseURl, anonKey: AppSecrets.supabaseAnon);

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));

  serviceLocator.registerFactory(
    () => InternetConnection(),
  );

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator<SupabaseClient>(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // UseCases
    ..registerFactory(
      () => UserSignUpUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLoginUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUserUsecase(
        serviceLocator(),
      ),
    )
    // BLoC
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator<SupabaseClient>(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // UseCases
    ..registerFactory(
      () => UploadBlogUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogsUseCase(
        serviceLocator(),
      ),
    )
    // BLoC
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlogUseCase: serviceLocator(),
        getAllBlogsUseCase: serviceLocator(),
      ),
    );
}
