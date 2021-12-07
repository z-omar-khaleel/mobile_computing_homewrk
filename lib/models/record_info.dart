class RecordInfo {
  String dateTime;
  double bmi;
  String status;
  double weight;
  double height;

  RecordInfo(
      {required this.dateTime,
      required this.bmi,
      required this.status,
      required this.weight,
      required this.height});

  Map<String, dynamic> toMap() {
    return {
      'dateTime': this.dateTime,
      'bmi': this.bmi,
      'status': this.status,
      'weight': this.weight,
      'height': this.height,
    };
  }

  factory RecordInfo.fromMap(Map<String, dynamic> map) {
    return RecordInfo(
      dateTime: map['dateTime'] as String,
      bmi: map['bmi'] as double,
      status: map['status'] as String,
      weight: map['weight'] as double,
      height: map['height'] as double,
    );
  }
}
