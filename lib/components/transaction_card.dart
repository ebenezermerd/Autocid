class TransactionData {
  String title;
  String date;
  String amount;
  String status;
  String stationId;
  String? imagePath;

  TransactionData({
    required this.title,
    required this.date,
    required this.amount,
    required this.stationId,
    required this.status,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionDate':
          '${DateTime.parse(date).millisecondsSinceEpoch}', // Store as a timestamp
      'transcationTitle': title,
      'amount': amount,
      'chargeStationId': stationId,
      'status': status,
    };
  }

  factory TransactionData.fromMap(Map<String, dynamic> data) {
    return TransactionData(
      amount: data['amount'],
      stationId: data['chargeStationId'],
      status: data['status'],
      title: data['transcationTitle'],
      date: data['transactionDate'],
    );
  }
}

class PriceCardData {
  final double watt;
  final int minutes;
  final double incharge;

  const PriceCardData(
      {required this.watt, required this.minutes, required this.incharge});
}

List<PriceCardData> priceCardDataList = [
  const PriceCardData(watt: 26, minutes: 20, incharge: 56),
  const PriceCardData(watt: 45, minutes: 30, incharge: 112),
  const PriceCardData(watt: 60, minutes: 55, incharge: 168),
  const PriceCardData(watt: 110, minutes: 120, incharge: 200),
  const PriceCardData(watt: 165, minutes: 145, incharge: 230),
  const PriceCardData(watt: 210, minutes: 165, incharge: 265),
];

List<TransactionData> transactions = [
  TransactionData(
      title: 'Your Transaction Will Appear Here',
      date: 'make a transaction to see it here',
      amount: 'amount',
      stationId: 'AKEB-12',
      status: 'status')
];
