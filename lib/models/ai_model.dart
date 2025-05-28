class AIModel {
  final String id;
  final String name;
  final String provider;
  final bool isFree;
  final String? description;

  const AIModel({
    required this.id,
    required this.name,
    required this.provider,
    required this.isFree,
    this.description,
  });

  @override
  String toString() => name;
}
