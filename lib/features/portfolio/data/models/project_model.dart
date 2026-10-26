import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  final String name;
  final String description;
  final String? language;
  final String htmlUrl;
  final bool fork;
  final String? playStoreUrl;
  final String? imageAsset;
  final String? imageUrl;

  const ProjectModel({
    required this.name,
    required this.description,
    this.language,
    required this.htmlUrl,
    required this.fork,
    this.playStoreUrl,
    this.imageAsset,
    this.imageUrl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json['name'] as String? ?? 'Unknown Project',
      description: json['description'] as String? ?? '',
      language: json['language'] as String?,
      htmlUrl: json['html_url'] as String? ?? '',
      fork: json['fork'] as bool? ?? false,
      playStoreUrl: json['play_store_url'] as String?,
      imageAsset: json['image_asset'] as String?,
      imageUrl: (json['image_url'] ?? json['homepage']) as String?,
    );
  }

  ProjectModel copyWith({
    String? name,
    String? description,
    String? language,
    String? htmlUrl,
    bool? fork,
    String? playStoreUrl,
    String? imageAsset,
    String? imageUrl,
  }) {
    return ProjectModel(
      name: name ?? this.name,
      description: description ?? this.description,
      language: language ?? this.language,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      fork: fork ?? this.fork,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
    name,
    description,
    language,
    htmlUrl,
    fork,
    playStoreUrl,
    imageAsset,
    imageUrl,
  ];
}
