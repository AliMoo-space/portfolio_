import 'package:portfolio/core/errors/exception.dart';
import 'package:portfolio/core/network/api_consumer.dart';
import 'package:portfolio/core/network/endpoints/api_endpoints.dart';
import '../models/project_model.dart';

class ProjectsRepository {
  final ApiConsumer apiConsumer;

  ProjectsRepository({required this.apiConsumer});

  Future<List<ProjectModel>> fetchProjects() async {
    try {
      final response = await apiConsumer.get(ApiEndpoints.githubUserRepos);
      final data = response.data;
      if (data is List) {
        return data
            .map((json) => ProjectModel.fromJson(json))
            .where((project) => !project.fork)
            .take(6)
            .toList();
      } else {
        throw const ServerException('Unexpected response format from GitHub API.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
