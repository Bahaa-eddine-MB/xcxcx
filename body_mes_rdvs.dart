import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:project_mesrdv/constants.dart';

class BodyMesRdvs extends StatefulWidget {
  const BodyMesRdvs({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyMesRdvs> createState() => _BodyMesRdvs();
}

class _BodyMesRdvs extends State<BodyMesRdvs> {
  @override
  void initState() {
    getPApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      color: bcgcolor,
      child: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (ctx, index) {
            return Container(
              padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                color: maincontainer,
                shadowColor: Colors.black,
                elevation: 3,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(11, 15, 10, 0),
                      child: Row(
                        children: <Widget>[
                          const CircleAvatar(
                            backgroundImage: AssetImage('images/doc9.jpg'),
                            radius: 32.5,
                          ),
                          SizedBox(width: w * 0.02),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctors[index]['DoctorsName'].toString(),
                                  style: const TextStyle(
                                      color: txtcolor, fontSize: 20),
                                ),
                                SizedBox(height: h * 0.01),
                                const Text(
                                  'cardiologue',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(224, 255, 255, 255)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          style: BorderStyle.none,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: seccontainer,
                      ),
                      //   margin: EdgeInsets.all(10),
                      height: h * 0.070,
                      width: w * 0.875,
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: txtcolor,
                              ),const SizedBox(width: 7),
                          Text(
                          readTimestampDate(doctors[index]['date']),
                          style: const TextStyle(color: txtcolor),
                          ),
                            ],
                          ),
                          
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                color: txtcolor,
                              ),const SizedBox(width: 7),
                          Text(
                          '${readTimestampTime(doctors[index]['date'])} '
                          ' - '
                          ' ${readTimestampTimeAddHour(doctors[index]['date'])}',
                          style: const TextStyle(color: txtcolor),
                          ),
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  ////////////////// TIME STAMP TO DATE TIME FOR AFFICHAGE
  String readTimestampDate(Timestamp timestamp) {
    DateFormat format = DateFormat.yMMMMEEEEd();
    return format.format(DateTime.parse(timestamp.toDate().toString()));
  }

  String readTimestampTime(Timestamp timestamp) {
    DateFormat format = DateFormat('HH:mm');
    return format.format(DateTime.parse(timestamp.toDate().toString()));
  }

  String readTimestampTimeAddHour(Timestamp timestamp) {
    DateFormat format = DateFormat('HH:mm');
    return format.format(DateTime.parse(
        timestamp.toDate().add(const Duration(hours: 1)).toString()));
  }

/////////////////////////////////////////////////////////////////// GET doctors for ur appointementS
  List doctors = [];
  CollectionReference doctorsref =
      FirebaseFirestore.instance.collection('Appointments');

  getPApp() async {
    QuerySnapshot resposne = await doctorsref
        .where('patientUID', isEqualTo: '43vju27PaOZptGuNQvDC')
        // .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day)))
        .orderBy('date')
        .get();
    setState(() {
      for (var element in resposne.docs) {
        doctors.add(element.data());
      }
    });
  }
}
