import 'package:afet_ihbar_mobile/disaster.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class notices extends StatefulWidget {
  const notices({super.key});

  @override
  State<notices> createState() => _noticesState();
}

class _noticesState extends State<notices> {

  var refDisaster = FirebaseDatabase.instance.ref().child('disasters');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffF00000),
          title:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Notices",style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),),
            ],
          )
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream:  refDisaster.onValue,
        builder: (context, event) {
          if(event.hasData)
          {
            var disastersList = <Disaster>[];
            var gelenData = event.data!.snapshot.value as dynamic;
            if(gelenData != null)
            {
              gelenData.forEach((key,nesne){
                var disaster = Disaster.fromJson(key,nesne);
                disastersList.add(disaster);
              });
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1/1
                ),
                itemCount: disastersList.length,
                itemBuilder: (context, index) {
                  var disasters = disastersList[index];
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Time : "),
                              Text("${disasters.time}"),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Name : "),
                              Text("${disasters.name}"),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Latitude : "),
                              Text("${disasters.latitude}"),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Longitude : "),
                              Text("${disasters.longitude}"),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: ()
                                  {
                                    showDialog
                                      (
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Warning Message !",style: TextStyle(
                                              color: Color(0xffF00000),
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            content: Text("Do you confirm that the selected notification was intervened ?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel",style: TextStyle(
                                                    color: Color(0xffF00000),
                                                    fontWeight: FontWeight.bold,
                                                  ),) ),
                                              TextButton(
                                                  onPressed: (){
                                                    refDisaster.child(disasters.id).remove();
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(content: Text("The notice has been deleted."))
                                                    );
                                                  },
                                                  child: Text("Confirm",style: TextStyle(
                                                    color: Color(0xffF00000),
                                                    fontWeight: FontWeight.bold,
                                                  ),)
                                              ),
                                            ],
                                          );
                                        },
                                    );
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: Color(0xffa8e063),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                        child: Text("Response Initiated")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    height: 25,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF00000),
                                        borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Response Pending")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },

              ),
            );
          }
          else
          {
            return Center();
          }
        },
      ),
    );
  }
}
