
class ChatModel{
  String? id;
  String? senderName;
  String? receiverName;
  String? senderId;
  String? receiverId;
  String? message;
  int? sentTime;
  String? isreaded;
  String? messageType;

  ChatModel({this.id, this.isreaded, this.senderName, this.receiverName, this.senderId, this.receiverId, this.message, this.messageType, this.sentTime});

  factory ChatModel.fromMap(Map<String, dynamic>? json) => ChatModel(
      id: json?['id'],
      isreaded: json?['isReaded'], 
      message: json?['message'],
      messageType: json?['messageType'], 
      receiverId: json?['receiverId'], 
      receiverName: json?['receiverName'], 
      senderId: json?['senderId'], 
      senderName: json?['senderName'], 
      sentTime: json?['sentTime']
      );

       Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isReaded': isreaded,
      'message': message,
      'messageType': messageType,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'senderId': senderId,
      'senderName': senderName,
      'sentTime': sentTime,
    };
  }

}