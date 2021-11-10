class MassegeModel {
  String? senderId;
  String? reseverId;

  String? text;

  String? dateTime;
  MassegeModel({
    required this.senderId,
    required this.text,
    required this.reseverId,
    required this.dateTime,
  });
  MassegeModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    reseverId = json['reseverId'];
    text = json['text'];

    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reseverId': reseverId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
