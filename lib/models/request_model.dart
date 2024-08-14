class RequestModel {
  
  final String identification;
  final int amount;
  final int quotas;
  final int total;
  final String status;

  RequestModel({
    required this.identification,
    required this.amount,
    required this.quotas,
    required this.total,
    required this.status,
  });

}