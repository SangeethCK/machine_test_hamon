import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/end_point/base_url.dart';
import 'package:machine_test/presentations/widgets/snackbars/snackbar.dart';

class NetworkProvider {
  final Dio _dio;

  NetworkProvider()
      : _dio = Dio(BaseOptions(
            baseUrl: baseUrl, headers: {"Content-Type": "application/json"})) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        log('------------------------------------------------------------------------------------------------');
        log('Request = ${jsonEncode(options.data)}', name: options.path);
        log('------------------------------------------------------------------------------------------------');

        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('************************************************************************************************');
        log('Response = ${response.data.toString()}',
            name: response.requestOptions.path);
        log('************************************************************************************************');

        return handler.next(response);
      },
      onError: (error, handler) async {
        log('Error-Response [${error.response?.statusCode}] = ${error.response.toString()}',
            name: error.requestOptions.path);

        switch (error.type) {
          case DioExceptionType.connectionError:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            final Response response = await retryRequest(error.requestOptions);
            handler.resolve(response);
            break;

          default:
            break;
        }

        switch (error.response?.statusCode) {
          case 401:
            kSnackBar(
                content:
                    'Unauthorized: Access is denied due to invalid token. Please try again!',
                error: true);
            break;
          default:
            return handler.next(DioException(
              requestOptions: error.requestOptions,
              response: error.response,
              error: error.response?.data['message'] ??
                  error.response?.data['error']['issues'][0]['message'] ??
                  'Unknown error occurred',
            ));
        }
      },
    ));
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (error) {
      log(error.toString());
      return Future.error(error);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (error) {
      log(error.toString());
      return Future.error(error);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (error) {
      log(error.toString());
      return Future.error(error);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (error) {
      log(error.toString());
      return Future.error(error);
    }
  }

  Future<Response<T>> retryRequest<T>(RequestOptions requestOptions) async {
    try {
      return await request<T>(requestOptions);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Response<T>> request<T>(RequestOptions requestOptions) async {
    return _dio.request<T>(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        extra: requestOptions.extra,
        headers: requestOptions.headers,
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        validateStatus: requestOptions.validateStatus,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        followRedirects: requestOptions.followRedirects,
        maxRedirects: requestOptions.maxRedirects,
        persistentConnection: requestOptions.persistentConnection,
        requestEncoder: requestOptions.requestEncoder,
        responseDecoder: requestOptions.responseDecoder,
        listFormat: requestOptions.listFormat,
      ),
    );
  }
}
