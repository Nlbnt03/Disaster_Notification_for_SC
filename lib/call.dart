import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://flutter.dev');

class Call extends StatefulWidget {
  const Call({super.key});

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {

  double enlem=0.0;
  double boylam=0.0;
  bool deger_konum=false;

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
          )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attention !',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffF00000),
                  ),
                ),
                Text(
                  '- If you are in an emergency, please press this button.',
                  style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '- This button will notify emergency services.',
                  style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'Please only press this button in an emergency.',
                  style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'Emergencies include:',
                  style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '* Fire',
                  style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '* Medical emergency',
                  style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '* Natural disaster',
                  style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '- If you are in an emergency, please do not panic and try to stay calm.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '- Pressing this button will help you.',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:  Text("Warning Message !",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffF00000),
                          ),),
                          content:  Text("Are you sure you want to call the emergency number ?",style: TextStyle(
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
                                final Uri _url = Uri(
                                  scheme: 'tel',
                                  path: '112',
                                );

                                await launch(_url.toString());
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Called"))
                                );
                              },
                              child: Text("Ok",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF00000),
                              ),),
                            )
                          ],
                        );
                      },);
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0,10.0),
                          blurRadius: 10.0,
                        )
                      ],
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:[Color(0xffF00000),Color(0xffDC281E)],
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 125,
                          height: 125,
                          child: Image.asset("images/callhelp.png")),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Warning Message !",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF00000),
                        ),),
                        content: Text("Are you sure you want to send an emergency message ?",style: TextStyle(
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
                              if(deger_konum == false)
                                {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("SMS could not be sent."))
                                  );
                                }
                              else
                                {
                                  final Uri _smsUrl = Uri(
                                    scheme: 'sms',
                                    path: '112',
                                    queryParameters: {'body': 'EMERGENCY! Help! My location is:\nLatitude : {$enlem}\nLongitude : {$boylam}'},
                                  );

                                  await launch(_smsUrl.toString());
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Sended SMS"))
                                  );
                                }
                            },
                            child: Text("Ok",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF00000),
                            ),),
                          )
                        ],
                      );
                    },);
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0,10.0),
                          blurRadius: 10.0,
                        )
                      ],
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:[Color(0xffF00000),Color(0xffDC281E)],
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 125,
                          height: 125,
                          child: Image.asset("images/Sendsms.png")),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
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
        ],
      ),
    );
  }
}
