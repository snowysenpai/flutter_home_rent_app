import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_rent/utils/button.dart';
import 'package:home_rent/utils/color.dart';
import 'package:home_rent/view/bottomnavi.dart';

class DestinationScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  final Popular;
  //method
  // ignore: non_constant_identifier_names
  const DestinationScreen({super.key, required this.Popular});
  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  // void _saveToSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final variables = {
  //     'id': widget.Popular.id,
  //     'imageUrl': widget.Popular.imageUrl,
  //     'city': widget.Popular.city,
  //     'country': widget.Popular.country,
  //     'description': widget.Popular.description,
  //     'rating': widget.Popular.rating,
  //     'prices': widget.Popular.prices,
  //   };

  //   List<Map<String, dynamic>> list;
  //   final jsonString = prefs.getString('variables_list');

  //   if (jsonString != null) {
  //     list = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  //   } else {
  //     list = [];
  //   }

  //   if (!list.any((item) => item['id'] == variables['id'])) {
  //     list.add(variables);

  //     prefs.setString('variables_list', jsonEncode(list));
  //   }

  //   _loadFromSharedPreferences();
  // }
  void _saveToFirestore() async {
    Map<String, dynamic> variables = {
      'id': widget.Popular.id,
      'imageUrl': widget.Popular.imageUrl,
      'city': widget.Popular.city,
      'country': widget.Popular.country,
      'description': widget.Popular.description,
      'rating': widget.Popular.rating,
      'prices': widget.Popular.prices,
    };

    List listDeneme = [];
    listDeneme.add(variables);
    CollectionReference collection =
        FirebaseFirestore.instance.collection('variables_list');
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await collection.doc(userId).set(
        {'listStars': FieldValue.arrayUnion(listDeneme)},
        SetOptions(merge: true));

    _loadFromFirestore();
  }

  void _saveToResevartionFirestore(String start, String end) async {
    try {
      Map<String, dynamic> variables = {
        'id': widget.Popular.id,
        'imageUrl': widget.Popular.imageUrl,
        'city': widget.Popular.city,
        'country': widget.Popular.country,
        'description': widget.Popular.description,
        'rating': widget.Popular.rating,
        'prices': widget.Popular.prices,
        'start': start,
        'end': end,
      };

      CollectionReference collection =
          FirebaseFirestore.instance.collection('reservation');
      String userId = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot doc = await collection.doc(userId).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<Map<String, dynamic>> listReservation =
            List<Map<String, dynamic>>.from(data['listReservation']);

        if (listReservation.any((item) => item['id'] == variables['id'])) {
          throw Exception('A reservation with the same ID already exists.');
        }
      }

      await collection.doc(userId).set({
        'listReservation': FieldValue.arrayUnion([variables])
      }, SetOptions(merge: true));
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('A reservation already exists.'),
            content: const Text(
                'You have already made a reservation for this property.'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _loadFromFirestore() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('variables_list');
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot doc = await collection.doc(userId).get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      if (data.isNotEmpty) {
        setState(() {
          var get = List<Map<String, dynamic>>.from(data['listStars']);
          savedHouses = get;
          loadStarIcon();
        });
      } else {}
    }
  }

  bool loadStarIcon() {
    for (var id in savedHouses) {
      if (id['id'] == widget.Popular.id) {
        return true;
      }
    }

    return false;
  }

  List<Map<String, dynamic>> savedHouses = [];
  // void _loadFromSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final jsonString = prefs.getString('variables_list');
  //   if (jsonString != null) {
  //     final list = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  //     // Now you can use the list of maps
  //     savedHouses = list;
  //     setState(() {
  //       loadStarIcon();
  //     });
  //     print(savedHouses);
  //   }
  // }

  void _onIconPressed() async {
    List<Map<String, dynamic>> list = savedHouses;
    if (list.any((item) => item['id'] == widget.Popular.id)) {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('variables_list');
      String userId = FirebaseAuth.instance.currentUser!.uid;

      Map<String, dynamic> itemToRemove =
          list.firstWhere((item) => item['id'] == widget.Popular.id);
      list.remove(itemToRemove);
      await collection.doc(userId).update({
        'listStars': FieldValue.arrayRemove([itemToRemove]),
      });
    } else {
      _saveToFirestore();
      loadStarIcon();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 330,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ],
                  ),
                  child: Hero(
                    tag: widget.Popular.imageUrl,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: Image(
                        image: AssetImage(widget.Popular.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //adding back arrow button
                Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.iconbg,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.primaryColor,
                              ),
                              color: Colors.black,
                              iconSize: 20.0,
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.iconbg,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                _onIconPressed();
                              },
                              icon: Icon(
                                loadStarIcon()
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //adding and Rating function
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.Popular.prices!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 20.0,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            widget.Popular.rating,
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // ABOUT ANS DESCRIPTION
                  Text(
                    widget.Popular.city,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    widget.Popular.description,
                    style:
                        const TextStyle(fontSize: 13.0, color: Colors.black45),
                  ),

                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'specification',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.bed,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('3 Beds')
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            indent: 3,
                            color: AppColors.primaryColor,
                          ),
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.bath,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('3 Bath')
                            ],
                          ),
                          Divider(
                            color: AppColors.primaryColor,
                          ),
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.kitchenSet,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Kitchen')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Listed By',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.iconbg,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Image.asset(
                              'assets/snowy.jpg',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Selimhan Yüksel'),
                          const SizedBox(
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  RoundButton(
                    title: "Make a Reservation",
                    onTap: () async {
                      await showDateRangePicker(
                        initialEntryMode: DatePickerEntryMode.calendar,
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                      ).then((value) {
                        if (value != null) {
                          _saveToResevartionFirestore(
                              value.start.toString().substring(0, 10),
                              value.end.toString().substring(0, 10));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavi(
                                        selectedIndex: 2,
                                      )));
                        }
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
