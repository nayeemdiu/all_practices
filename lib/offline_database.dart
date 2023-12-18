// import 'dart:convert';
// import 'dart:io';
//
// import 'package:all_practices/follow_model.dart';
// import 'package:flutter/material.dart';
//
// import 'Database/database_helper.dart';
//
// class OfflineDatabase extends StatefulWidget {
//   const OfflineDatabase({Key? key}) : super(key: key);
//
//   @override
//   State<OfflineDatabase> createState() => _OfflineDatabaseState();
// }
//
// class _OfflineDatabaseState extends State<OfflineDatabase> {
//   bool isLoading = false;
//   List<followUpModel> followupList = [];
//
//   List dashboardList = [];
//   void fetchLeadList() async {
//     print("Secured Api ");
//     //Get user dat from local device
//     String token = "WZrrZ7XbOv7u491XE86OPCmaPEDn03JG";
//     String userId = "8";
//     String type = "Total FollowUp";
//
//     Map<String, String> body = {"type": type, "user_id": userId};
//
//     // Api url
//     String url = "https://crm.ihelpbd.com/crm/api/crm/followUp-data-view.php";
//     HttpClient httpClient = HttpClient();
//
//     HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
//
//     // content type
//     request.headers.set('content-type', 'application/json');
//     request.headers.set('token', token);
//
//     request.add(utf8.encode(json.encode(body)));
//
//     //Get response
//     HttpClientResponse response = await request.close();
//     String reply = await response.transform(utf8.decoder).join();
//     final data = jsonDecode(reply);
//     print(data);
//     httpClient.close();
//     print("Api data  : ${data}");
//     final item = json.decode(reply)["data"];
//     if (data["status"].toString().contains("200")) {
//       setState(() async {
//         try {
//           // followupList = item;
//           var followup = jsonDecode(reply)["data"];
//           for (var i in followup) {
//             followupList.add(followUpModel.fromMap(i));
//           }
//           await DatabaseHelper.instance
//               .insertFollowUp(followupList);
//
//           isLoading = false;
//           //pageCommentAndAttachment = allData;
//         } catch (e) {
//           isLoading = true;
//         }
//       });
//     } else {
//       followupList = [];
//       isLoading = false;
//       print("status code not valid");
//     }
//   }
//
//   @override
//   void initState() {
//     fetchLeadList();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Offline Database"),
//         centerTitle: true,
//       ),
//       body:  Expanded(
//           child: FutureBuilder(
//               future: DatabaseHelper.instance.getfollowuplist(),
//               builder: (context,  snapshot) {
//                 if (snapshot.hasError) {
//                   return Text("Error");
//                 }
//                 return ListView.builder(
//                   itemBuilder: (context, index) {
//                   return ListTile(
//
//                     leading: Text(snapshot.data!.company.toString()),
//                   );
//                 },);
//
//
//               })),
//     );
//   }
// }
