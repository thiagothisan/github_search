import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/repositories/search_repository.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements ISearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);
  test('Deve retornar uma lista de ResultSearch', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    final result = await usecase("Thiago");

    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Deve retornar um InvalidTextError caso o texto seja invalido',
      () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    var result = await usecase(null);
    expect(result.fold(id, id), isA<InvalidTextError>());
    result = await usecase("");
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
