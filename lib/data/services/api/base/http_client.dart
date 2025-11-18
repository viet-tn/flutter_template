import 'dart:io' show HttpHeaders, ContentType;

import 'package:dio/dio.dart' hide LogInterceptor;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/models/env/env.dart';
import '../../../repositories/token/token_repository_impl.dart';
import '../interceptors/log_interceptor.dart';
import '../interceptors/refresh_token_interceptor.dart';

part 'http_client.g.dart';

final _options = BaseOptions(
  baseUrl: Env.apiBaseUrl,
  connectTimeout: Env.connectTimeout,
  receiveTimeout: Env.receiveTimeout,
  sendTimeout: Env.sendTimeout,
  responseType: ResponseType.json,
  headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
);

@Riverpod(keepAlive: true)
Dio tokenHttpClient(Ref ref) {
  final client = Dio(_options);
  client.interceptors.add(LogInterceptor());
  ref.onDispose(client.close);
  return client;
}

@Riverpod(keepAlive: true)
Dio httpClient(Ref ref) {
  final client = Dio(_options);
  final tokenRepo = ref.watch(tokenRepositoryProvider);
  client.interceptors.addAll([
    RefreshTokenInterceptor(tokenRepo),
    LogInterceptor(),
  ]);

  ref.onDispose(client.close);
  return client;
}
