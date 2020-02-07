import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<bool> sendNotification(
      String token, String title, String message) async {
    String endURL = "https://fcm.googleapis.com/fcm/send";
    String firebaseKey =
        "AAAA7Op3J9U:APA91bHaH4Yhty7Iz8N55SnjXBXD5Ee5lxSJ7d4uZLAhHzJGlcWWi-bhVV3GTGHweJwRHJskTqHiDFnk7dSQ7lejK6KYKNkKpQT1Yz-j4b6jKgScFPQZqRLXwymsHRdvF_WhWgSzPKe-";
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "key=$firebaseKey"
    };

    String json =
        '{ "to" : "$token", "notification" : { "body" : "${message}", "title": "${title}", } }';
debugPrint(json);
    http.Response response =
        await http.post(endURL, headers: headers, body: json);

    if (response.statusCode == 200) {
      print("success");
      return true;
    } else {
      return false;
    }
  }
}
