class NotificationModel{
  String? id; 
  String? isReaded; 
  String? title;
  String? message;
  String? to;
  String? from;
  int? sentTime;

  NotificationModel({this.id, this.title, this.message, this.to, this.from, this.sentTime,this.isReaded});

  factory NotificationModel.fromMap(Map<String, dynamic>? json) => NotificationModel(
      id: json?['id'],
      title: json?['title'],
      message: json?['message'], 
      to: json?['to'], 
      from: json?['from'],
      isReaded: json?['isReaded'],
      sentTime: json?['sentTime']
      );

       Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'to': to,
      'isReaded': isReaded,
      'from': from,
      'sentTime': sentTime,
    };
  }

}