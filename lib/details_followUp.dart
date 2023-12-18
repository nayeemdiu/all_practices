import 'dart:convert';
import 'dart:io';

import 'package:all_practices/follow_model.dart';
import 'package:all_practices/static_variable.dart';
import 'package:flutter/material.dart';


class DetailsFollowUp extends StatefulWidget {
  DetailsFollowUp({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsFollowUp> createState() => _DetailsFollowUpState();
}

class _DetailsFollowUpState extends State<DetailsFollowUp> {
  List followupList = [];
  bool isLoading = false;
  final followUpModel followupmodel = followUpModel();
  /// Update Note Editing  controller
  TextEditingController noteController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idControler = TextEditingController();

  ///  Lead call status Dropdown menu

  List<String> leadCallStatusName = ["Busy", "Switch off", "Connected"];

  // void PostSecureApi() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //  // // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //  //  String token = sharedPreferences.getString("token").toString();
  //  //  print(" new token  : ${token}");
  //  //  String userId = sharedPreferences.getString("userId").toString();
  //  //  print("user id  : ${userId}");
  //
  //   /// body type
  //   String type = "Total FollowUp";
  //
  //   Map<String, String> body = {"type": type, "user_id": userId};
  //
  //   // Api url
  //   String url = "https://crm.ihelpbd.com/crm/api/crm/followUp-data-view.php";
  //   HttpClient httpClient = HttpClient();
  //
  //   HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  //
  //   // content type
  //   request.headers.set('Content-Type', 'application/json');
  //   request.headers.set('token', token);
  //
  //   request.add(utf8.encode(json.encode(body)));
  //
  //   //Get response
  //   HttpClientResponse response = await request.close();
  //   String reply = await response.transform(utf8.decoder).join();
  //   var data = jsonDecode(reply);
  //   httpClient.close();
  //   print("Api data  : ${data}");
  //   final item = json.decode(reply)["data"];
  //   if (data["status"].toString().contains("200")) {
  //     setState(() {
  //       try {
  //         followupList = item;
  //         isLoading = false;
  //         //pageCommentAndAttachment = allData;
  //       } catch (e) {
  //         isLoading = true;
  //       }
  //     });
  //   } else {
  //     followupList = [];
  //     isLoading = false;
  //     print("status code not valid");
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    // PostSecureApi();
    StaticVariable.callStatus = "";
    StaticVariable.note = "";
    // UpdateFollowUpDataToServer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(StaticVariable.followupmodel!.company.toString(),style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor:  Color.fromRGBO(164, 255, 238, 0.8), ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              getDetailsFollowUp(),
              Text(
                "Update Follow Up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              updateDetailsFollowUp(),
            ],
          ),
        ));
  }

  getDetailsFollowUp() {
    return SafeArea(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blueGrey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(10),
        elevation: 1,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color:Color.fromRGBO(164, 255, 238, 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoRow("Id", StaticVariable.followupmodel!.id.toString(),
                  Colors.orange),
              InfoRow("Company Name",
                  StaticVariable.followupmodel!.company.toString(), Colors.blue),
              InfoRow(
                  "Phone Number",
                  StaticVariable.followupmodel!.number.toString(),
                  Colors.black87),
              InfoRow("Note", StaticVariable.followupmodel!.note.toString(),
                  Colors.blueGrey),
              InfoRow(
                  "Create Date",
                  StaticVariable.followupmodel!.createDate.toString(),
                  Colors.blueGrey),
              InfoRow(
                  "Call Status",
                  StaticVariable.followupmodel!.call_status.toString(),
                  Colors.green),
              InfoRow(
                  "Follow Type",
                  StaticVariable.followupmodel!.follow_type.toString(),
                  Colors.blueGrey),
              InfoRow(
                  "Followup Date",
                  StaticVariable.followupmodel!.followup_date.toString(),
                  Colors.blueGrey),
              InfoRow(
                  "Creator",
                  StaticVariable.followupmodel!.creator.toString(),
                  Colors.blueGrey),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget InfoRow(String label, String value, Color labelColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label : ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: labelColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: labelColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// New Changed Sk Nayeem Ur Rahman
  /// Updata Follow up data to sand server

  // Future<void> UpdateFollowUpDataToServer(
  //     String followUpId,
  //     String callStatus,
  //     String follow_des,
  //     ) async {
  //   CustomProgressIndicator customProgress = CustomProgressIndicator(context);
  //   try {
  //     customProgress.showDialog(
  //         "Please wait", SimpleFontelicoProgressDialogType.spinner);
  //     //Show progress dialog
  //     SharedPreferences sharedPreferences =
  //     await SharedPreferences.getInstance();
  //     String token = sharedPreferences.getString("token").toString();
  //     String userId = sharedPreferences.getString("userId").toString();
  //     //Api url
  //     String url = 'https://crm.ihelpbd.com/crm/api/crm/followUp-update.php';
  //     //Authentication
  //
  //     print("Follow Up Update to server properly ");
  //
  //     Map<String, String> body = {
  //       "status": callStatus,
  //       "follow_des": follow_des,
  //       "followupId": followUpId,
  //       "userId": userId,
  //     };
  //
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
  //
  //     // Closed request
  //     httpClient.close();
  //
  //     final data = jsonDecode(reply);
  //     print(data);
  //
  //     //Check response code
  //     if (data["status"].toString().contains("200")) {
  //       //Hide progress
  //       customProgress.hideDialog();
  //
  //       // ignore: use_build_context_synchronously
  //       await showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text("Congratulations"),
  //           content: Text(data["data"], style: const TextStyle(fontSize: 16)),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Ok'),
  //             ),
  //           ],
  //         ),
  //       );
  //     } else {
  //       //Hide progress
  //       customProgress.hideDialog();
  //       // ignore: use_build_context_synchronously
  //       await showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text("Server Error"),
  //           content:
  //           Text(data["data"], style: const TextStyle(color: Colors.red)),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Ok'),
  //             ),
  //           ],
  //         ),
  //       );
  //       //Hide progress
  //       // customProgress.hideDialog();
  //     }
  //   } catch (e) {
  //     //Hide progress
  //     customProgress.hideDialog();
  //
  //     await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text("Server Error"),
  //         content:
  //         Text(e.toString(), style: const TextStyle(color: Colors.red)),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Ok'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  updateDetailsFollowUp() {
    return Column(
      children: [
        ///nayeem old update follow up
        // Card(
        //   shape: RoundedRectangleBorder(
        //     side: BorderSide(
        //       color: Colors.blueGrey,
        //       width: 0.5,
        //     ),
        //     borderRadius: BorderRadius.circular(10.0),
        //   ),
        //   margin: EdgeInsets.all(10),
        //   elevation: 3,
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 15,
        //       ),
        //
        //       /// Follow up details update Note
        //
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: CallstatusNote(),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: TextField(
        //           controller: noteController,
        //           maxLines: 1,
        //           decoration: const InputDecoration(
        //               contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        //               border: OutlineInputBorder(),
        //               labelText: "Note",
        //               hintText: "Write a note.."),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 25,
        //       ),
        //
        //       ///Save & close button
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             //close button
        //             Flexible(
        //               flex: 1,
        //               fit: FlexFit.tight,
        //               child: AnimatedButton(
        //                 width: 150,
        //                 text: 'Close',
        //                 isReverse: true,
        //                 selectedTextColor: Colors.blue,
        //                 transitionType: TransitionType.LEFT_TO_RIGHT,
        //                 backgroundColor: Colors.grey,
        //                 borderRadius: 15,
        //                 borderWidth: 2,
        //                 onPress: () {
        //                   // Navigator.of(context,rootNavigator: true).pop();
        //                   Navigator.of(context).pop();
        //                 },
        //               ),
        //             ),
        //
        //             const SizedBox(
        //               width: 10,
        //             ),
        //
        //             // update button
        //             Flexible(
        //               flex: 1,
        //               fit: FlexFit.tight,
        //               child: AnimatedButton(
        //                 width: 150,
        //                 text: 'Update',
        //                 isReverse: true,
        //                 selectedTextColor: Colors.blue,
        //                 transitionType: TransitionType.LEFT_TO_RIGHT,
        //                 backgroundColor: Colors.blue,
        //                 borderRadius: 15,
        //                 borderWidth: 2,
        //                 onPress: () {
        //                   // UpdateFollowUpDataToServer("374","solved","ggdfggedrttedt");
        //
        //                   if (StaticVariable.callStatus.isEmpty) {
        //                     CustomAlertDialog.showAlert(
        //                         "Call status field is required", context);
        //                   }
        //                   //FollowUpCreateAPI followUpCreateAPI = FollowUpCreateAPI(context);
        //                   UpdateFollowUpDataToServer(
        //                       StaticVariable.followupmodel.id.toString(),
        //                       StaticVariable.callStatus,
        //                       noteController.text);
        //
        //                   print(StaticVariable.followupmodel.id.toString());
        //                   print(StaticVariable.callStatus);
        //                   print(noteController.text);
        //                 },
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        Card(
          //  color:Colors.grey,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blueGrey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.all(10),
          elevation: 1, // Increased elevation for a subtle shadow
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color:Color.fromRGBO(164, 255, 238, 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),

                /// Follow up details update Note

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: CallstatusNote(),
                // ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: noteController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        border: OutlineInputBorder(),
                        labelText: "Note",
                        hintText: "Write a note.."),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                ///Save & close button
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       //close button
                //       Flexible(
                //         flex: 1,
                //         fit: FlexFit.tight,
                //         child: AnimatedButton(
                //           width: 150,
                //           text: 'Close',
                //           isReverse: true,
                //           selectedTextColor: Colors.blue,
                //           transitionType: TransitionType.LEFT_TO_RIGHT,
                //           backgroundColor: Colors.grey,
                //           borderRadius: 15,
                //           borderWidth: 2,
                //           onPress: () {
                //             // Navigator.of(context,rootNavigator: true).pop();
                //             Navigator.of(context).pop();
                //           },
                //         ),
                //       ),
                //
                //       const SizedBox(
                //         width: 10,
                //       ),
                //
                //       // update button
                //       Flexible(
                //         flex: 1,
                //         fit: FlexFit.tight,
                //         child: AnimatedButton(
                //           width: 150,
                //           text: 'Update',
                //           textStyle: TextStyle(color: Colors.black,fontSize: 18),
                //           isReverse: true,
                //           selectedTextColor: Color.fromRGBO(22, 138, 116, 0.8),
                //           transitionType: TransitionType.LEFT_TO_RIGHT,
                //           backgroundColor:Color.fromRGBO(22, 138, 116, 0.8),
                //           borderRadius: 15,
                //           borderWidth: 2,
                //           onPress: () {
                //             // UpdateFollowUpDataToServer("374","solved","ggdfggedrttedt");
                //
                //             if (StaticVariable.callStatus.isEmpty) {
                //               CustomAlertDialog.showAlert(
                //                   "Call status field is required", context);
                //             }
                //             //FollowUpCreateAPI followUpCreateAPI = FollowUpCreateAPI(context);
                //             UpdateFollowUpDataToServer(
                //                 StaticVariable.followupmodel.id.toString(),
                //                 StaticVariable.callStatus,
                //                 noteController.text);
                //
                //             print(StaticVariable.followupmodel.id.toString());
                //             print(StaticVariable.callStatus);
                //             print(noteController.text);
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}