import 'package:portfolio/core/errors/exception.dart';
import 'package:portfolio/core/network/api_consumer.dart';
import 'package:portfolio/core/network/endpoints/api_endpoints.dart';
import '../models/project_model.dart';

class _CuratedProjectMeta {
  final String description;
  final String? playStoreUrl;
  final String? imageAsset;

  const _CuratedProjectMeta({
    required this.description,
    this.playStoreUrl,
    this.imageAsset,
  });
}

const Map<String, _CuratedProjectMeta> _curatedMeta = {
  'workwise': _CuratedProjectMeta(
    description:
        'HR Management Application: Authentication, attendance, leave management, performance tracking, and AI assistant. Includes location-based attendance, Dio token refresh, FCM/local notifications, Clean Architecture, BLoC/Cubit, and GoRouter.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.alimohamed.workwise',
    imageAsset: 'assets/workwise.jpg',
  ),
  'rental_hub': _CuratedProjectMeta(
    description:
        'Community Sharing Platform: Peer-to-peer item/property rental, REST API integration, secure token storage, and loading/error handling.',
    imageAsset: 'assets/rental_hub.png',
  ),
  'trendora': _CuratedProjectMeta(
    description:
        'E-Commerce Application: Product browsing, category filtering, shopping cart using Cubit, Dio, and feature-based architecture.',
  ),
  'cosmetics_app': _CuratedProjectMeta(
    description:
        'Store and Delivery Application: Shopping and checkout, Google Maps pickup/delivery, Dio, and BLoC.',
  ),
};

class ProjectsRepository {
  final ApiConsumer apiConsumer;

  /// Excluded repositories that must never be displayed in the portfolio.
  /// Matched case-insensitively using repository name.
  static const Set<String> _excludedRepoNames = {
    'cinema_booking',
    'el-hamaky_store',
    'portfolio_',
    'test',
    'alimo8',
  };

  ProjectsRepository({required this.apiConsumer});

  Future<List<ProjectModel>> fetchProjects() async {
    try {
      final response = await apiConsumer.get(ApiEndpoints.githubUserRepos);
      final data = response.data;
      if (data is List) {
        final parsedProjects = data
            .whereType<Map<String, dynamic>>()
            .map((json) {
              final rawModel = ProjectModel.fromJson(json);
              final meta = _curatedMeta[rawModel.name.toLowerCase().trim()];
              if (meta != null) {
                return rawModel.copyWith(
                  description: rawModel.description.isNotEmpty
                      ? rawModel.description
                      : meta.description,
                  playStoreUrl: meta.playStoreUrl,
                  imageAsset: meta.imageAsset,
                );
              }
              return rawModel;
            })
            .toList();

        // Filtering: exclude explicitly disallowed repos and repos without language.
        // Keep relevant forked projects alongside original repositories.
        final relevantProjects = parsedProjects.where((project) {
          final nameLower = project.name.toLowerCase().trim();

          // 1. Explicit exclusion (case-insensitive) - cinema_booking, El-Hamaky_store, etc.
          if (_excludedRepoNames.contains(nameLower)) {
            return false;
          }

          // 2. Curated showcase projects are always included
          final isCurated = _curatedMeta.containsKey(nameLower);
          if (isCurated) return true;

          // 3. Exclude repos without code language
          if (project.language == null) {
            return false;
          }
          return true;
        }).toList();

        // Ensure curated projects remain displayed alongside other relevant repos
        final curatedProjects = relevantProjects
            .where((p) => _curatedMeta.containsKey(p.name.toLowerCase()))
            .toList();
        final otherRelevant = relevantProjects
            .where((p) => !_curatedMeta.containsKey(p.name.toLowerCase()))
            .toList();

        const maxDisplayLimit = 6;
        final availableSlots = maxDisplayLimit - curatedProjects.length;
        final selectedOthers = otherRelevant
            .take(availableSlots > 0 ? availableSlots : 0)
            .toSet();

        // Preserve existing sorting behavior (GitHub updated order)
        return relevantProjects
            .where(
              (p) => curatedProjects.contains(p) || selectedOthers.contains(p),
            )
            .take(maxDisplayLimit)
            .toList();
      } else {
        throw const ServerException(
          'Unexpected response format from GitHub API.',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
