import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class PushNotification {
 String firebaseMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(
          {
             "type": "service_account",
      "project_id": "push-notification-event-app",
      "private_key_id": "7f90cbc8758a1c99cbc089d47ca2905ff39e5512",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDB6FYYszgB5gQH\nf6qXER7no4vnvDxfAYx0P8jFD5InyVWVavTCX+lzTn1h1ZL4PhTi86vETdl1F306\nimh95c8hgzhrqKmCO3+XtDVDNqL0voBPvjczax7tnhpU7nSaReET1Bz6cQuTaL99\nH+VaOwD5PLqPOv6ZkBmfOGYO8NIVEyoz5mMvyfe+rM/oWt1sBuw+oJThs0AiMPfu\nGwHDNhcmkOyVvribawMYRBdJHcO4cowFqFbkl+9GQa6V9GG2LzljrMxu1pcdCx77\nhxp2ie2ySXvHq81vDRTssczl3EoYdNMOj/t3kBFbpJ41Ho1YVetG22f5hMYs3Pfx\nILWJTSq1AgMBAAECggEAAaBnDnx8YQmyqXRw9CT03ykQTKCX2g0rhjMdxkdn6LUH\n5oG37WR8ExdKtnYh7jqpFrFIFNS5WQHaL1JHZ5z0pJmS8NZAm8LPgnCEzNxJuCdb\n8K9OC7yfjQs5OdKpQD0LUw0BtDkcCX/EsXJBzIS3sJ+JiheK2LNsf5krw/7RqFMV\nzzsiR55DH5oIBdSfWdejSuhzyGvTVAFWepo2hQ97kwhDa8wdorPQl9hKjRj9mE6U\nfPD5EIum00R5jmY3SaiP8IPmXR4pGtQCph5exVS+ffQ+6ExxBWLcBnN/RzoMBvHu\noD9ocorJBNODcQIpzdhDTtXTfB5LiYmtiCJ5SrwoGQKBgQD+1qbTnj6wGdZKMuZj\nH/ehGfbOnE2/3J9Rt6d9FbFTO6nRhYC6Y2WRT9RTfSfIT7VVoxEiBW34aikKuBkw\n2qrRAGQtoCrWC8E0Ok0wllm8m5uh8IrXNrfAluEYpnO0EYdwmP4/Ce1VxihWfbOv\nTSIuDi+AqFjMtTKTpRgr388N2QKBgQDCypb8EVmS6ZFt6GC4A6djGomN/ADq3ylY\n8KDdJLpe3G0fdYHlKFQBIj9iSppFxvR9Rdqb5E1MdqySOtzZmoKdq6c0+fdwC/8S\nZIy8upQo2N4cpI7Tm7E5LpKMGJtXg9x4nG/EmcP/3ljhm+T1jl9TAPZC2Kqt/a1i\n3vLNUb0OPQKBgAPic8KQC/aVPj39TqO+LgEnqyp1GX5ON6OAQC5Y8U4Kf8kw1siA\nkWDIrbzkEIIuLN50UOOK36VEwQFn0wJ6otXywpQrd9uxbC2GofyWniGQ4atzRjqH\nm/90jVPZ3bOl/MGLo3yEgzimf6Dp455Nd7LqBnFYn5nnPTEg+CBbFgXpAoGAC0JC\nb9dg4gj2CvA/huNPLX8/LCHAu9KiRS3DXoTc8Na0x/i2xVQLZvVfzIKbYCUbxJHh\nDNmpTh4d42XblghEPHDLfVhlYOiQmbOOHup53dKLJASu7LQ3DiMO/WH+uJQ6jg4c\nt7Rbi9KCOKgWF8te3yFTGpIDa4MaHnjcd9mdn9ECgYEAyeUC5dSqHVgYw+C5VNte\nAuVamld8dQJQmVg/5TazcGAjRumPCZvPqWyXINqvFZO7OFUNenwRQZy2uHbVAfyj\ncfCBEfP6u1pOx0dwAmWfuSMCfk+r4yr6610mnahgEd47xiaedd9IOJO6OpZybfrt\ne81IXU1N0i1BE3xdmMKEkJU=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "push-notification-for-event-ap@push-notification-event-app.iam.gserviceaccount.com",
      "client_id": "110825710059006850669",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/push-notification-for-event-ap%40push-notification-event-app.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
          },
        ),
        [firebaseMessagingScope]);
    final accessToken = client.credentials.accessToken.data;

    return accessToken;
  }
}

  // static Future<String> getAccessToken() async {
  //   final serviceAccountJson = {
  //     "type": "service_account",
  //     "project_id": "push-notification-event-app",
  //     "private_key_id": "7f90cbc8758a1c99cbc089d47ca2905ff39e5512",
  //     "private_key":
  //         "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDB6FYYszgB5gQH\nf6qXER7no4vnvDxfAYx0P8jFD5InyVWVavTCX+lzTn1h1ZL4PhTi86vETdl1F306\nimh95c8hgzhrqKmCO3+XtDVDNqL0voBPvjczax7tnhpU7nSaReET1Bz6cQuTaL99\nH+VaOwD5PLqPOv6ZkBmfOGYO8NIVEyoz5mMvyfe+rM/oWt1sBuw+oJThs0AiMPfu\nGwHDNhcmkOyVvribawMYRBdJHcO4cowFqFbkl+9GQa6V9GG2LzljrMxu1pcdCx77\nhxp2ie2ySXvHq81vDRTssczl3EoYdNMOj/t3kBFbpJ41Ho1YVetG22f5hMYs3Pfx\nILWJTSq1AgMBAAECggEAAaBnDnx8YQmyqXRw9CT03ykQTKCX2g0rhjMdxkdn6LUH\n5oG37WR8ExdKtnYh7jqpFrFIFNS5WQHaL1JHZ5z0pJmS8NZAm8LPgnCEzNxJuCdb\n8K9OC7yfjQs5OdKpQD0LUw0BtDkcCX/EsXJBzIS3sJ+JiheK2LNsf5krw/7RqFMV\nzzsiR55DH5oIBdSfWdejSuhzyGvTVAFWepo2hQ97kwhDa8wdorPQl9hKjRj9mE6U\nfPD5EIum00R5jmY3SaiP8IPmXR4pGtQCph5exVS+ffQ+6ExxBWLcBnN/RzoMBvHu\noD9ocorJBNODcQIpzdhDTtXTfB5LiYmtiCJ5SrwoGQKBgQD+1qbTnj6wGdZKMuZj\nH/ehGfbOnE2/3J9Rt6d9FbFTO6nRhYC6Y2WRT9RTfSfIT7VVoxEiBW34aikKuBkw\n2qrRAGQtoCrWC8E0Ok0wllm8m5uh8IrXNrfAluEYpnO0EYdwmP4/Ce1VxihWfbOv\nTSIuDi+AqFjMtTKTpRgr388N2QKBgQDCypb8EVmS6ZFt6GC4A6djGomN/ADq3ylY\n8KDdJLpe3G0fdYHlKFQBIj9iSppFxvR9Rdqb5E1MdqySOtzZmoKdq6c0+fdwC/8S\nZIy8upQo2N4cpI7Tm7E5LpKMGJtXg9x4nG/EmcP/3ljhm+T1jl9TAPZC2Kqt/a1i\n3vLNUb0OPQKBgAPic8KQC/aVPj39TqO+LgEnqyp1GX5ON6OAQC5Y8U4Kf8kw1siA\nkWDIrbzkEIIuLN50UOOK36VEwQFn0wJ6otXywpQrd9uxbC2GofyWniGQ4atzRjqH\nm/90jVPZ3bOl/MGLo3yEgzimf6Dp455Nd7LqBnFYn5nnPTEg+CBbFgXpAoGAC0JC\nb9dg4gj2CvA/huNPLX8/LCHAu9KiRS3DXoTc8Na0x/i2xVQLZvVfzIKbYCUbxJHh\nDNmpTh4d42XblghEPHDLfVhlYOiQmbOOHup53dKLJASu7LQ3DiMO/WH+uJQ6jg4c\nt7Rbi9KCOKgWF8te3yFTGpIDa4MaHnjcd9mdn9ECgYEAyeUC5dSqHVgYw+C5VNte\nAuVamld8dQJQmVg/5TazcGAjRumPCZvPqWyXINqvFZO7OFUNenwRQZy2uHbVAfyj\ncfCBEfP6u1pOx0dwAmWfuSMCfk+r4yr6610mnahgEd47xiaedd9IOJO6OpZybfrt\ne81IXU1N0i1BE3xdmMKEkJU=\n-----END PRIVATE KEY-----\n",
  //     "client_email":
  //         "push-notification-for-event-ap@push-notification-event-app.iam.gserviceaccount.com",
  //     "client_id": "110825710059006850669",
  //     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  //     "token_uri": "https://oauth2.googleapis.com/token",
  //     "auth_provider_x509_cert_url":
  //         "https://www.googleapis.com/oauth2/v1/certs",
  //     "client_x509_cert_url":
  //         "https://www.googleapis.com/robot/v1/metadata/x509/push-notification-for-event-ap%40push-notification-event-app.iam.gserviceaccount.com",
  //     "universe_domain": "googleapis.com"
  //   };
  //   List<String> scopes = [
  //     "https://www.googleapis.com/auth/userinfo.email",
  //     "https://www.googleapis.com/auth/firebase.database",
  //     "https://www.googleapis.com/auth/firebase.messaging"
  //   ];
  //   http.Client client = await auth.clientViaServiceAccount(
  //     auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
  //     scopes,
  //   );

  //   auth.AccessCredentials credentials =
  //       await auth.obtainAccessCredentialsViaServiceAccount(
  //           auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
  //           scopes,
  //           client);

  //   client.close();

  //   return credentials.accessToken.data;
  // }

  // Future<void> sendFCMMessage() async {
  //   final String serverAccessTokenKey = await getAccessToken();
  //   final String endpointFirebaseCloudMessaging =
  //       'http://fcm.googleapis.com/v1/projects/push-notification-event-app/messages:send';
  //   final CurrentFCMToken = await FirebaseMessaging.instance.getToken();

  //   final Map<String, dynamic> message = {
  //     'message': {
  //       'token': CurrentFCMToken,
  //       'notification': {
  //         'title': "FCM Message",
  //         // 'body' : "PickUp Location: $pickUpAddress \nDropOff Location: $dropOffDestinationAddress"
  //         'body': "body Request successfull"
  //       },
  //       'data': {
  //         'current_user_FCM_token': CurrentFCMToken,
  //       }
  //     }
  //   };
  //   final http.Response response = await http.post(
  //     Uri.parse(endpointFirebaseCloudMessaging),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $serverAccessTokenKey'
  //     },
  //     body: jsonEncode(message),
  //   );

  //   if (response.statusCode == 200) {
  //     print("Notification sent successfully");
  //   } else {
  //     print("Failed to send FCM message: ${response.statusCode}");
  //   }
  // }
  // }

  // static sendNotificationToSelectedDriver(
  //     String deviceToken, BuildContext context) async {
  //   // String dropOffDestinationAddress = Provider.of<AppInfo>(context, listen: false).dropOffLocation!.placeName.toString();
  //   // String pickUpAddress = Provider.of<AppInfo>(context, listen: false).pickUpLocation!.placeName.toString();

  //   final String serverAccessTokenKey = await getAccessToken();
  //   String endpointFirebaseCloudMessaging =
  //       'http://fcm.googleapis.com/v1/projects/push-notification-event-app/messages:send';

  //   final Map<String, dynamic> message = {
  //     'message': {
  //       'token': deviceToken,
  //       'notification': {
  //         'title': "NET TRIP REQUEST from $UserName",
  //         // 'body' : "PickUp Location: $pickUpAddress \nDropOff Location: $dropOffDestinationAddress"
  //         'body': "body Request successfull"
  //       },
  //     }
  //   };

  //   final http.Response response = await http.post(
  //     Uri.parse(endpointFirebaseCloudMessaging),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $serverAccessTokenKey'
  //     },
  //     body: jsonEncode(message),
  //   );

  //   if (response.statusCode == 200) {
  //     print("Notification sent successfully");
  //   } else {
  //     print("Failed to send FCM message: ${response.statusCode}");
  //   }
  // }

