import 'dart:io';

import 'package:kreait_dreams/controller/dreams_controller.dart';

import 'kreait_dreams.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class KreaitDreamsChannel extends ApplicationChannel {
  ManagedContext context;
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
      (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = KreaitDreamsConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName,);
  
    context = ManagedContext(dataModel, persistentStore);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint => Router()

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    ..route('/dreams/[:id]').link(() => DreamsController(context))

    ..route('/').linkFunction((request) => 
    Response.ok('Hello, World!')..contentType = ContentType.html)

    ..route('/client').linkFunction((request) async {
      final client = await File('client.html').readAsString();
      return Response.ok(client)..contentType = ContentType.html;
    });
}

class KreaitDreamsConfig extends Configuration {
  KreaitDreamsConfig(String path): super.fromFile(File(path));

  DatabaseConfiguration database;
}