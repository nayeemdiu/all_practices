import 'dart:convert';
import 'dart:io';

import 'package:all_practices/Home_page.dart';
import 'package:all_practices/follow_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'details_followUp.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {

  bool isLoading = false;
  List followupList = [];

  List dashboardList = [];
  void fetchLeadList() async {
    print("Secured Api ");
    //Get user dat from local device
    String token = "WZrrZ7XbOv7u491XE86OPCmaPEDn03JG";
    String userId = "8";
    String type = "Total FollowUp";

    Map<String, String> body = {"type": type, "user_id": userId};

    // Api url
    String url = "https://crm.ihelpbd.com/crm/api/crm/followUp-data-view.php";
    HttpClient httpClient = HttpClient();

    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

    // content type
    request.headers.set('content-type', 'application/json');
    request.headers.set('token', token);

    request.add(utf8.encode(json.encode(body)));

    //Get response
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    final data = jsonDecode(reply);
    print(data);
    httpClient.close();
    print("Api data  : ${data}");
    final item = json.decode(reply)["data"];
    if (data["status"].toString().contains("200")) {
      setState(() {
        try {
          followupList = item;
          followupList = jsonDecode(reply)["data"];

          isLoading = false;
          //pageCommentAndAttachment = allData;
        } catch (e) {
          isLoading = true;
        }
      });
    }else {
      followupList = [];
      isLoading = false;
      print("status code not valid");
    }
  }

  @override
  void initState() {
    fetchLeadList();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Total FollowUp"),centerTitle: true,
      actions: [
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:  (context) => HomePage(),));
        }, child: Text("Grid View",style: TextStyle(color: Colors.red),)),

      ],),
      body: getFollowup(),
    );
  }

  getFollowup() {
    if (followupList.contains(null) || isLoading) {
      return const Center(
        child: Skeletonizer(
            child: Column(
              children: [
                ListTile(
                  title: Text("Title Text sampole"),
                  leading: Text("Text"),
                  subtitle: Text("subtitle text"),
                  trailing: Icon(Icons.call),
                ),
                ListTile(
                  title: Text("Title Text sampole"),
                  leading: Text("Text"),
                  subtitle: Text("subtitle text"),
                  trailing: Icon(Icons.call),
                ),
                ListTile(
                  title: Text("Title Text sampole"),
                  leading: Text("Text"),
                  subtitle: Text("subtitle text"),
                  trailing: Icon(Icons.call),
                ),

                ListTile(
                  title: Text("Title Text sampole"),
                  leading: Text("Text"),
                  subtitle: Text("subtitle text"),
                  trailing: Icon(Icons.call),
                ),
                ListTile(
                  title: Text("Title Text sampole"),
                  leading: Text("Text"),
                  subtitle: Text("subtitle text"),
                  trailing: Icon(Icons.call),
                ),
                ListTile(
                  title: Text("Title Text sampole"),
                  leading: Text("Text"),
                  subtitle: Text("subtitle text"),
                  trailing: Icon(Icons.call),
                ),
                ListTile(
                  title: Text("Title Text sampole"),
                  leading: Text("Text"),
                  subtitle: Text("subtitle text"),
                  trailing: Icon(Icons.call),
                ),
                ListTile(
                  title: Text("Title Text sampole"),
                  leading: Text("Text"),
                  subtitle: Text("subtitle text"),
                  trailing: Icon(Icons.call),
                ),
              ],
            )),
      );
    }

    /// Total Follow up page
    return SafeArea(
      child: Card(
        color: Color.fromRGBO(238, 246, 245, 0.9254901960784314),
        child: ListView.builder(
          reverse: false,
          itemCount: followupList.length,
          itemBuilder: (context, index) {
            followUpModel leadModel =
            followUpModel.fromMap(followupList[index]);
            return SafeArea(
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.5,
                    color: Colors.grey, //<-- SEE HERE
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  tileColor: Color.fromRGBO(164, 255, 238, 0.2),
                  title: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(leadModel.company.toString(),
                              style:
                              TextStyle(color: Color.fromRGBO(11, 82, 69, 0.8), fontSize: 16)),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            leadModel.number.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            leadModel.followup_date.toString(),
                            style:
                            TextStyle(color: Colors.blueGrey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Color.fromARGB(77, 155, 206, 203),
                    child: IconButton(
                      icon: const Icon(
                        Icons.call,
                        size: 25,
                      ),
                      color: Colors.green,
                      onPressed: () {

                      },
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsFollowUp(),
                        ));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }