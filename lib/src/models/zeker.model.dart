class Zeker {
  final int id;
  final int order;
  final int category;
  final int count;
  final String? header;
  final String content;
  final String? comment;
  bool favorited;

  Zeker({
    required this.id,
    required this.order,
    required this.category,
    required this.count,
    required this.header,
    required this.content,
    required this.comment,
    this.favorited = false,
  });
}
