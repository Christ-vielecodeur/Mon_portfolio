import 'package:get/get.dart';

class AirportInfo {
  final String city;
  final String country;
  final String airportName;
  final String code;
  final DateTime dateTime;

  const AirportInfo({
    required this.city,
    required this.country,
    required this.airportName,
    required this.code,
    required this.dateTime,
  });
}

class CarrierInfo {
  final String name;
  final String avatarUrl;
  final double rating;
  final int reviewsCount;
  final bool verified;

  const CarrierInfo({
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.reviewsCount,
    this.verified = false,
  });
}

class PackageDetailsController extends GetxController {
  final RxString trackingNumber = '4509534'.obs;
  final RxString status = 'En Transit'.obs;

  final Rx<AirportInfo> departure = const AirportInfo(
    city: 'Dakar',
    country: 'Sénégal',
    airportName: 'Aéroport International Blaise Diagne (AIBD)',
    code: 'DSS',
    dateTime: DateTime(2025, 8, 16, 10, 30),
  ).obs;

  final Rx<AirportInfo> arrival = const AirportInfo(
    city: 'Paris',
    country: 'France',
    airportName: 'Aéroport Paris-Charles-de-Gaulle (CDG)',
    code: 'CDG',
    dateTime: DateTime(2025, 8, 19, 17, 15),
  ).obs;

  final Rx<CarrierInfo> carrier = const CarrierInfo(
    name: 'Camille Dubois',
    avatarUrl: 'https://i.pravatar.cc/120?img=5',
    rating: 5.0,
    reviewsCount: 12,
    verified: true,
  ).obs;

  final RxList<String> contents = <String>['Vêtements', 'cosmétiques'].obs;

  final RxList<String> photoUrls = <String>[
    'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?w=600&q=80',
    'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=600&q=80',
    'https://images.unsplash.com/photo-1520975922203-bc2c8f3f7f91?w=600&q=80',
  ].obs;
}
