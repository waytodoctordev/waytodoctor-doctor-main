// class NotificationModelNew {
//   final String createdAt;
//   final String type;

//   final String content;
//   final int routeId;
//   final int notificationId;

//   const NotificationModelNew({
//     required this.routeId,
//     required this.type,
//     required this.content,
//     required this.notificationId,
//     required this.createdAt,
//   });

//   static NotificationModelNew fromJson(Map<String, dynamic> json) =>
//       NotificationModelNew(
//         type: json["type"],
//         content: json["content"],
//         routeId: json["route_id"],
//         notificationId: json['id'],
//         createdAt: json['created_at'],
//       );

//   Map<String, dynamic> toJson() => {
//         'type': type,
//         'content': content,
//         'route_id': routeId,
//         'id': notificationId,
//         'created_at': createdAt,
//       };
// }
