class OrderReq {
  final int? page;
  final int? prePage;
  OrderReq({
    required this.page,
    required this.prePage,
  });

  Map<String, dynamic> toJson() => {
        'page': page ?? 1,
        'pre_page': prePage ?? 10,
      };
}
