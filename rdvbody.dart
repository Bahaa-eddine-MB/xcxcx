import 'package:flutter/material.dart';
import 'package:project_mesrdv/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RdvBody extends StatefulWidget {
  const RdvBody({Key? key}) : super(key: key);

  @override
  State<RdvBody> createState() => _RdvBodyState();
}

class _RdvBodyState extends State<RdvBody> {
  @override
  void initState() {
    getPApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bcgcolor,
      child: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (ctx, index) {
            return Container(
              // height: h*0.15,
              padding: const EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.black,
                elevation: 5,
                child: Row(
                  children: <Widget>[
                    const Padding(
                        // padding circle avatar left
                        padding: EdgeInsets.all(6)),
                    const SizedBox(
                      height: 90,
                      child: CircleAvatar(
                        backgroundColor: bcgcolor,
                        radius: 34,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/doc9.jpg'),
                          radius: 32.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Expanded(
                      // overflow from right handeling
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            doctors[index]['DoctorsName'].toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(readTimestamp(doctors[index]['date'])),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: const [
                        Icon(
                          Icons.schedule_rounded,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("En Attent")
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

/////////////////////////////////////////////////////////////////// patients
  List patients = [];

  var patientsref = FirebaseFirestore.instance
      .collection('patients')
      .doc('43vju27PaOZptGuNQvDC')
      .collection('appointments');

  getData() async {
    var resposne = await patientsref.orderBy('date').get();
    print('===================================');

    setState(() {
      resposne.docs.forEach((element) {
        patients.add(element.data());
        print(resposne.docs);
      });
    });
    print(patients);
    print('===================================');
  }

  addAppP() async {
    patientsref.add({
      'doc': 'Dr Nassim',
      'date': Timestamp.fromDate(DateTime.utc(2022, 7, 20, 15, 00))
    });
  }

  ////////////////// TIME STAMP TO DATE TIME
  String readTimestamp(Timestamp timestamp) {
    DateFormat format = DateFormat('yyyy-MM-dd hh:mm');
    return format.format(DateTime.parse(timestamp.toDate().toString()));
  }

/////////////////////////////////////////////////////////////////// doctors for ur appointement
  List doctors = [];
  CollectionReference doctorsref =
      FirebaseFirestore.instance.collection('Appointments');

  getPApp() async {
    QuerySnapshot resposne = await doctorsref
        .where('patientUID', isEqualTo: '43vju27PaOZptGuNQvDC')
        .orderBy('date')
        .get();
    setState(() {
      resposne.docs.forEach((element) {
        doctors.add(element.data());
      });
    });
    print('*********************************');
  }

/////////////// tbh ikd whats dis
  addAppD() async {
    patientsref.doc('ESZRpvBU231nSOryTg0G').set({
      'Patient': 'Nassim',
    });
    patientsref.add({
      'Patient': 'Nassim',
      'date': Timestamp.fromDate(DateTime.utc(2022, 7, 20, 15, 00))
    });
  }
}
