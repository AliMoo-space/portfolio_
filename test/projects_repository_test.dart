import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/network/api_consumer.dart';
import 'package:portfolio/features/portfolio/data/repositories/projects_repository.dart';

class MockApiConsumer implements ApiConsumer {
  final dynamic mockData;

  MockApiConsumer(this.mockData);

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return Response(
      data: mockData,
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );
  }

  @override
  Future<Response<dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async => throw UnimplementedError();

  @override
  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async => throw UnimplementedError();

  @override
  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async => throw UnimplementedError();

  @override
  Future<Response<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async => throw UnimplementedError();
}

void main() {
  test('fetchProjects includes relevant forks and curated projects with descriptions', () async {
    final mockResponseList = [
      {
        'name': 'workwise',
        'description': null,
        'language': 'Dart',
        'html_url': 'https://github.com/AliMoo-space/workwise',
        'fork': true,
      },
      {
        'name': 'cinema_booking',
        'description': null,
        'language': 'Dart',
        'html_url': 'https://github.com/AliMoo-space/cinema_booking',
        'fork': false,
      },
      {
        'name': 'El-Hamaky_store',
        'description': null,
        'language': 'Dart',
        'html_url': 'https://github.com/AliMoo-space/El-Hamaky_store',
        'fork': false,
      },
      {
        'name': 'test',
        'description': null,
        'language': null,
        'html_url': 'https://github.com/AliMoo-space/test',
        'fork': false,
      },
      {
        'name': 'rental_hub',
        'description': null,
        'language': 'Dart',
        'html_url': 'https://github.com/AliMoo-space/rental_hub',
        'fork': false,
      },
      {
        'name': 'portfolio_',
        'description': null,
        'language': 'JavaScript',
        'html_url': 'https://github.com/AliMoo-space/portfolio_',
        'fork': false,
      },
      {
        'name': 'cosmetics_app',
        'description': null,
        'language': 'Dart',
        'html_url': 'https://github.com/AliMoo-space/cosmetics_app',
        'fork': false,
      },
      {
        'name': 'Trendora',
        'description': null,
        'language': 'Dart',
        'html_url': 'https://github.com/AliMoo-space/Trendora',
        'fork': false,
      },
    ];

    final repository = ProjectsRepository(
      apiConsumer: MockApiConsumer(mockResponseList),
    );

    final projects = await repository.fetchProjects();

    // Verification 1: Length is capped at 6
    expect(projects.length, lessThanOrEqualTo(6));

    // Verification 2: Relevant forked project 'workwise' is NOT filtered out
    final workwise = projects.firstWhere((p) => p.name == 'workwise');
    expect(workwise.fork, isTrue);
    expect(workwise.description, contains('HR Management Application'));
    expect(workwise.playStoreUrl, isNotNull);
    expect(workwise.imageAsset, equals('assets/workwise.jpg'));

    // Verification 3: Irrelevant 'test' and 'portfolio_' are excluded
    expect(projects.any((p) => p.name == 'test'), isFalse);
    expect(projects.any((p) => p.name == 'portfolio_'), isFalse);

    // Verification 4: cinema_booking and El-Hamaky_store are strictly excluded
    expect(projects.any((p) => p.name.toLowerCase() == 'cinema_booking'), isFalse);
    expect(projects.any((p) => p.name.toLowerCase() == 'el-hamaky_store'), isFalse);

    // Verification 5: Curated projects are present with their CV descriptions and assets
    final rental = projects.firstWhere((p) => p.name == 'rental_hub');
    expect(rental.description, contains('Community Sharing Platform'));
    expect(rental.imageAsset, equals('assets/rental_hub.png'));

    final cosmetics = projects.firstWhere((p) => p.name == 'cosmetics_app');
    expect(cosmetics.description, contains('Store and Delivery Application'));

    final trendora = projects.firstWhere((p) => p.name == 'Trendora');
    expect(trendora.description, contains('E-Commerce Application'));
  });
}
