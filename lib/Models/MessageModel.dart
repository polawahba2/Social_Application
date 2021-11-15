class MessageModel {
  String? senderId;
  String? reciverId;
  String? dateTime;
  String? text;

  MessageModel({
    this.senderId,
    this.reciverId,
    this.dateTime,
    this.text,
  });
  MessageModel.fromJson(Map<String, dynamic>? json) {
    {
      reciverId = json!['reciverId'];
      senderId = json['senderId'];
      dateTime = json['dateTime'];
      text = json['text'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'reciverId': reciverId,
      'senderId': senderId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
