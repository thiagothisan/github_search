import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/external/datasources/github_datasource.dart';
import 'package:github_search/modules/search/utils/github_response.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubDatasource(dio);

  test('deve retornar uma lista de ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final future = datasource.getSearch('searchText');
    expect(future, completes);
  });

  test('deve retornar um error se o statusCode nao for 200', () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.getSearch('searchText');
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test('deve retornar um Exception se tiver erro no Dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.getSearch('searchText');
    expect(future, throwsA(isA<Exception>()));
  });
}
