class Popular {
  int id;
  String imageUrl;
  String city;
  String country;
  String description;
  String rating;
  String prices;
  String? dateTime;
  //List<Activity> activities;

  Popular({
    required this.id,
    required this.imageUrl,
    required this.city,
    required this.country,
    required this.description,
    required this.rating,
    required this.prices,
    this.dateTime,
  });
  int get getId => id;
  String get getImageUrl => imageUrl;
  String get getCity => city;
  String get getCountry => country;
  String get getDescription => description;
  String get getRating => rating;
  String get getPrices => prices;
}

// //destination data
// List<Popular> destinations = [
//   Popular(
//     id: 0,
//     imageUrl: 'assets/property11.jpg',
//     city: '3BHK Villa, 1400 Sqft',
//     country: 'The USA',
//     description:
//         'Villa with pool ideal for large families.\n3 bedrooms, 3 bathrooms, 3 living room',
//     rating: '4.8 (13 Reviews)',
//     prices: "25000 USD / per month\n+100000 USD Deposit",
//   ),
//   Popular(
//     id: 1,
//     imageUrl: 'assets/property5.jpg',
//     city: 'Abbot, 1500  Sqft',
//     country: 'Hazara',
//     description:
//         'Letraset sheets containing Lorem Ipsum passages, and more recently ',
//     rating: '4.5 (28 Reviews)',
//     prices: 'Rs 15000 / per month\n+50000 Deposit',
//   ),
//   Popular(
//     id: 2,
//     imageUrl: 'assets/property6.jpg',
//     city: '3BHK Villa, 1400  Sqft',
//     country: 'Hazara',
//     description:
//         'Letraset sheets containing Lorem Ipsum passages, and more recently ',
//     rating: '4.0 (28 Reviews)',
//     prices: 'Rs 5000 / per month\n+10000 Deposit',
//   ),
//   Popular(
//     id: 3,
//     imageUrl: 'assets/property1.jpg',
//     city: '3BHK Villa, 1400  Sqft',
//     country: 'Hazara',
//     description:
//         'Elettra sheets containing Lorem Ipsum passages, and more recently ',
//     rating: '3.5 (34 Reviews)',
//     prices: 'Rs 22000 / per month\n+50000 Deposit',
//   ),
//   Popular(
//     id: 4,
//     imageUrl: 'assets/property2.jpg',
//     city: '3BHK Villa, 1400  Sqft',
//     country: 'Hazara',
//     description:
//         'Elettra sheets containing Lorem Ipsum passages, and more recently ',
//     rating: '4.9 (12 Reviews)',
//     prices: 'Rs 25000 / per month\n+70000 Deposit',
//   ),
//   Popular(
//     id: 5,
//     imageUrl: 'assets/property1.jpg',
//     city: '3BHK Villa, 1400  Sqft',
//     country: 'Hazara',
//     description:
//         'Letraset sheets containing Lorem Ipsum passages, and more recently ',
//     rating: '4.2 (23 Reviews)',
//     prices: 'Rs 25000 / per month\n+70000 Deposit',
//   ),
//   Popular(
//     id: 6,
//     imageUrl: 'assets/property2.jpg',
//     city: '3BHK Villa, 1400  Sqft',
//     country: 'Hazara',
//     description:
//         'Letraset sheets containing Lorem Ipsum passages, and more recently ',
//     rating: '4.2 (23 Reviews)',
//     prices: 'Rs 25000 / per month\n+70000 Deposit',
//   ),
// ];
