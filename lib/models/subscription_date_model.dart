class SubscriptionDetail {
  final DateTime firstDate;
  final DateTime lastDate;
  final String price;
  final String identifier;

  SubscriptionDetail(
      {required this.lastDate,
      required this.firstDate,
      required this.price,
      required this.identifier});
}
