import 'dart:io';

import 'package:dart_api_collection/dart_api_collection.dart';

void main() async {
  ApiConfig.logConfig
    ..enableLog = true
    ..showResponseHeader = false;
  final user = Platform.environment['MIXDROP_EMAIL']!;
  final key = Platform.environment['MIXDROP_KEY']!;
  final mixdropClient = MixdropApi(user, key);
  final listFolder = await mixdropClient.folderList();
  print(listFolder?.toJson());
}
