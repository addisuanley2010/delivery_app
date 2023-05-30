// // CHAPUBK_TEST-nXneuyrO9fclPHri2otEePg7TUdnxMrn
// //CHASECK_TEST-B9NAg4f5BeHFsjCu1Ew6Cr2oyyj7YH6h






// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ChapaWebhookHandler extends StatefulWidget {
//   @override
//   _ChapaWebhookHandlerState createState() => _ChapaWebhookHandlerState();
// }

// class _ChapaWebhookHandlerState extends State<ChapaWebhookHandler> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final String _webhookUrl = 'https://your-webhook-url.com/chapa-webhook';
//   bool _isListening = false;
//   late StreamSubscription<http.Response> _subscription;



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text('Chapa Webhook Handler'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(_isListening ? 'Listening for webhooks...' : 'Not listening'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isListening ? stopListening : startListening,
//               child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> startListening() async{
//     // Subscribe to the webhook URL using a stream
//     _subscription = http
//         .get(Uri.parse(_webhookUrl))
//         .asStream()
//         .where((response) => response.statusCode == 200)
//         .listen((response) {
//       List<dynamic> notifications = jsonDecode(response.body);
//       for (var notification in notifications) {
//         _processWebhookNotification(notification);
//       }
//     });

//     setState(() {
//       _isListening = true;
//     });
//     _scaffoldKey.currentState!.showSnackBar(const SnackBar(
//       content: Text('Listening for Chapa webhooks...'),
//     ));
//   }

//   Future<void> stopListening() async {
//     // Cancel the webhook subscription
//     if (_subscription != null) {
//       _subscription.cancel();
//     }

//     setState(() {
//       _isListening = false;
//     });
//     _scaffoldKey.currentState!.showSnackBar(SnackBar(
//       content: Text('Stopped listening for Chapa webhooks'),
//     ));
//   }

//   void _handleWebhookNotification(Map<String, dynamic> notification) {
//     String eventType = notification['event'];
//     Map<String, dynamic> data = notification['payload'];

//     switch (eventType) {
//       case 'payment.authorized':
//         // Handle payment authorized event
//         break;
//       case 'payment.captured':
//         // Handle payment captured event
//         break;
//       case 'payment.refunded':
//         // Handle payment refunded event
//         break;
//       case 'payment.cancelled':
//        // Handle payment cancelled event
//         break;
//       default:
//         print('Unknown event type: $eventType');
//         break;
//     }
//   }

//   Future<void> _processWebhookNotification(Map<String, dynamic> notification) async {
//     // Send a response back to Chapa to acknowledge receipt of the webhook notification
//     String webhookId = notification['id'];
//     String webhookUrl = notification['url'];
//     String responseUrl = '$webhookUrl/response/$webhookId';
//     http.post(Uri.parse(responseUrl), body: {}).then((response) {
//       if (response.statusCode == 200) {
//         print('Webhook notification response sent successfully');
//       } else {
//         print('Error sending webhook notification response: ${response.statusCode}');
//       }
//     }).catchError((error) {
//       print('Error sending webhook notification response: $error');
//     });

//     // Handle the webhook notification
//     _handleWebhookNotification(notification['payload']);
//   }

//   @override
//   void dispose() {
//     // Cancel the webhook subscription when the widget is disposed
//     if (_subscription != null) {
//       _subscription.cancel();
//     }
//     super.dispose();
//   }
// }