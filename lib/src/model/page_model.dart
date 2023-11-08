class PageModel<T> {
  final List<T> docs;
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool? hasPrevPage;
  final bool? hasNextPage;
  final int? prevPage;
  final int? nextPage;

  PageModel({
    required this.docs,
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  factory PageModel.fromJson(Map<String, dynamic> json, Function fromMapData) {
    final items = json['docs'].cast<Map<String, dynamic>>();
    return PageModel(
      docs: List<T>.from(items.map((e) => fromMapData(e))),
      totalDocs: json['totalDocs'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      page: json['page'],
      pagingCounter: json['pagingCounter'],
      hasPrevPage: json['hasPrevPage'],
      hasNextPage: json['hasNextPage'],
      prevPage: json['prevPage'],
      nextPage: json['nextPage'],
    );
  }

  factory PageModel.noneData() => PageModel(docs: [], totalDocs: 0, limit: 0, totalPages: 0, page: 0, pagingCounter: 0);

  Map<String, dynamic> toJson(Function toMapData) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docs'] = docs.map((e) => toMapData(e)).toList();
    data['totalDocs'] = totalDocs;
    data['limit'] = limit;
    data['totalPages'] = totalPages;
    data['page'] = page;
    data['pagingCounter'] = pagingCounter;
    data['hasPrevPage'] = hasPrevPage;
    data['hasNextPage'] = hasNextPage;
    data['prevPage'] = prevPage;
    data['nextPage'] = nextPage;
    return data;
  }
}
