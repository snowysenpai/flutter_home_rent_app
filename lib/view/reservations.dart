import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/utils/color.dart';

class MyReservationsPage extends StatefulWidget {
  const MyReservationsPage({super.key});

  @override
  State<MyReservationsPage> createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('reservation');

  Future<List<Map<String, dynamic>>> fetchReservations() async {
    DocumentSnapshot doc = await collection.doc(userId).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return List<Map<String, dynamic>>.from(data['listReservation']);
    }
    return [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: const Text(
              'My Reservations',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchReservations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> reservation = snapshot.data![index];
                return Card(
                  color: const Color.fromARGB(255, 227, 240, 243),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Reservation Dates: ${reservation['start']} - ${reservation['end']}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () async {
                            await collection.doc(userId).update({
                              'listReservation':
                                  FieldValue.arrayRemove([reservation])
                            });
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Reservation deleted'),
                              ),
                            );
                            setState(() {});
                          },
                        ),
                        leading: const Icon(
                          Icons.home_outlined,
                          color: Colors.blue,
                          size: 35,
                        ),
                        title: Text(
                            'Title: ${reservation['city']} Country: ${reservation['country']} '),
                        subtitle: Text(
                          reservation['description'],
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                      Image.asset(reservation['imageUrl']),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
