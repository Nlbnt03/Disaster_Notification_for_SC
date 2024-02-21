
import 'dart:collection';

import 'package:afet_ihbar_mobile/call.dart';
import 'package:afet_ihbar_mobile/notices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';


class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {



  String report_name = "";
  int selectedIndex = -1;

  bool deger_konum=false;
  double enlem=0.0;
  double boylam=0.0;

  var afetler = ["Earthquake","Fire","Avalanche","Landslide","Flood"];
  var afet_image = ["images/deprem.png","images/yangin.png","images/cıg.png","images/heyelan.png","images/sel.png"];

  int _currentPageIndex = 0;


  var refDisasters =FirebaseDatabase.instance.ref().child("disasters");

  Future<void> report(String name) async
  {
    var konum = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var disaster = HashMap<String,dynamic>();

    enlem = konum.latitude;
    boylam = konum.longitude;
    String timestampString = DateFormat('yyyy-MM-dd HH:mm:ss').format(Timestamp.now().toDate());


    disaster["name"] = name;
    disaster["latitude"] = enlem;
    disaster["longitude"] = boylam;
    disaster["time"] = timestampString;
    refDisasters.push().set(disaster);
  }

  Future<void> konumAl() async {
    await Geolocator.requestPermission();
    var konum = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      enlem=konum.latitude;
      boylam=konum.longitude;
    });
    deger_konum=!deger_konum;
  }

  @override
  void initState() {
    super.initState();
    konumAl();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffF00000),
          title:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Disaster Notification",style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),),
            ],
          ),
        leading: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Call(),));
          },
            child: Image.asset("images/call.png")),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => notices(),));
            },
              child: Image.asset("images/NOTİCES.png"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Which disaster report do you want to make?",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.arrow_left,size: 48,),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 1),
                    itemCount: afetler.length,
                    onPageChanged:(index){
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex = -1; // Tekrar tıklanırsa, seçimi kaldır
                              report_name = ""; // report_name'i boşalt
                            } else {
                              selectedIndex = index;
                              report_name = afetler[index]; // Seçilen öğenin metnini report_name'e ata
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: selectedIndex == index ? Color(0xffF00000) : Color(0xff0C1756), // Seçili öğe kırmızı, diğerleri koyu mavi
                          ),
                          width: 150,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Image.asset(afet_image[index]),
                                height: 120,
                                width: 120,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  afetler[index],
                                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },

                  ),
                ),
                GestureDetector(
                  onTap: (){},
                    child: Icon(Icons.arrow_right,size: 48,)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < afetler.length; i++)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: i == _currentPageIndex ? Colors.red : Colors.black, // Aktif noktayı vurgula
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0,bottom: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(deger_konum? "GPS Status: Location Received !" : "GPS Status: Receiving Location...",style: TextStyle(
                        color: deger_konum? Color(0xff52c234) : Color(0xffF00000),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Latitude",style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),),
                            Text("$enlem",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Longitude",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),),
                            Text("$boylam",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           GestureDetector(
             onTap: ()
             {
               showDialog(
                   context: context,
                   builder: (BuildContext context){
                     return AlertDialog(
                       title: Text("Warning message !",style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: Color(0xffF00000),
                       ),),
                       content: Text("You are about to make a report for a disaster in your location. Do you want to make a report?",style: TextStyle(
                           fontWeight: FontWeight.bold
                       ),),
                       actions: [
                         TextButton(
                           onPressed: (){
                             Navigator.pop(context);
                           },
                           child: Text("Cancel",style: TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Color(0xffF00000),
                           ),),
                         ),
                         TextButton(
                           onPressed: () async{
                              report(report_name);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Disaster was declared."))
                              );
                           },
                           child: Text("Ok",style: TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Color(0xffF00000),
                           ),),
                         )
                       ],
                     );
                   }
               );
             },
             child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(15)),
                 color: Color(0xffF00000)
               ),
               width: 200,
               height: 40,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(Icons.emergency_share_sharp,color: Colors.white,),
                   Padding(
                     padding: const EdgeInsets.only(left: 15.0),
                     child: Text("Report",style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                       color: Colors.white
                     ),),
                   ),
                 ],
               ),
             ),
           ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0,left: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                      width: 100,
                      child: Image.asset("images/logo.png")),
                  Text("Developed by Nalbantsoft", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
