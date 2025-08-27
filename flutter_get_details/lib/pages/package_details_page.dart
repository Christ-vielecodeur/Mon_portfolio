import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/package_details_controller.dart';

class PackageDetailsPage extends StatefulWidget {
  const PackageDetailsPage({super.key});

  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  final PackageDetailsController controller =
      Get.put(PackageDetailsController(), permanent: true);

  String _formatDate(DateTime dateTime) {
    final DateFormat dateFmt = DateFormat.EEEE('fr_FR');
    final DateFormat dayFmt = DateFormat.d('fr_FR');
    final DateFormat monthFmt = DateFormat.MMMM('fr_FR');
    final DateFormat yearFmt = DateFormat.y('fr_FR');
    final DateFormat timeFmt = DateFormat.Hm('fr_FR');
    return '${_capitalize(dateFmt.format(dateTime))}. ${dayFmt.format(dateTime)} ${_capitalize(monthFmt.format(dateTime))} ${yearFmt.format(dateTime)}, ${timeFmt.format(dateTime)}';
  }

  String _capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final Color cardBorder = const Color(0xFFE6EAF1);
    final Color subtleText = const Color(0xFF6B7280);
    final Color blue = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back<void>(),
        ),
        title: const Text('Détails'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeaderCard(cardBorder: cardBorder, subtleText: subtleText, blue: blue),
              const SizedBox(height: 12),
              _FlightCard(cardBorder: cardBorder, subtleText: subtleText),
              const SizedBox(height: 12),
              _CarrierCard(cardBorder: cardBorder, blue: blue, subtleText: subtleText),
              const SizedBox(height: 12),
              _ContentsCard(cardBorder: cardBorder, subtleText: subtleText),
              const SizedBox(height: 12),
              _PhotosCard(cardBorder: cardBorder),
              const SizedBox(height: 20),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    shape: const StadiumBorder(),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Get.snackbar('Suivre le colis', 'Fonction à implémenter');
                  },
                  child: const Text('Suivre le colis', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.cardBorder,
    required this.subtleText,
    required this.blue,
  });

  final Color cardBorder;
  final Color subtleText;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    final PackageDetailsController c = Get.find<PackageDetailsController>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text('Colis N° ${c.trackingNumber.value}',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => Get.snackbar('Code', 'Générer le code QR et le code PIN'),
                  child: Text(
                    'Générez le code QR et le code PIN',
                    style: TextStyle(
                      color: blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B3D),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(c.status.value, style: TextStyle(color: subtleText, fontWeight: FontWeight.w600)),
                ],
              )),
        ],
      ),
    );
  }
}

class _FlightCard extends StatelessWidget {
  const _FlightCard({required this.cardBorder, required this.subtleText});

  final Color cardBorder;
  final Color subtleText;

  String _formatDate(DateTime dateTime) {
    final DateFormat dateFmt = DateFormat.EEEE('fr_FR');
    final DateFormat dayFmt = DateFormat.d('fr_FR');
    final DateFormat monthFmt = DateFormat.MMMM('fr_FR');
    final DateFormat yearFmt = DateFormat.y('fr_FR');
    final DateFormat timeFmt = DateFormat.Hm('fr_FR');
    String cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
    return '${cap(dateFmt.format(dateTime))}. ${dayFmt.format(dateTime)} ${cap(monthFmt.format(dateTime))} ${yearFmt.format(dateTime)}, ${timeFmt.format(dateTime)}';
  }

  @override
  Widget build(BuildContext context) {
    final PackageDetailsController c = Get.find<PackageDetailsController>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Détail du vol', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 12),
          Obx(() {
            final dep = c.departure.value;
            return _FlightPoint(
              title: 'Départ',
              cityCountry: '${dep.city}, ${dep.country}',
              airport: dep.airportName,
              date: _formatDate(dep.dateTime),
            );
          }),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          Obx(() {
            final arr = c.arrival.value;
            return _FlightPoint(
              title: 'Arrivé',
              cityCountry: '${arr.city}, ${arr.country}',
              airport: arr.airportName,
              date: _formatDate(arr.dateTime),
            );
          }),
        ],
      ),
    );
  }
}

class _FlightPoint extends StatelessWidget {
  const _FlightPoint({
    required this.title,
    required this.cityCountry,
    required this.airport,
    required this.date,
  });

  final String title;
  final String cityCountry;
  final String airport;
  final String date;

  @override
  Widget build(BuildContext context) {
    final Color subtleText = const Color(0xFF6B7280);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.flight_takeoff_rounded, color: Color(0xFF335CFF)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(cityCountry, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 4),
              Text(airport, style: TextStyle(color: subtleText)),
              const SizedBox(height: 4),
              Text(date, style: TextStyle(color: subtleText)),
            ],
          ),
        ),
      ],
    );
  }
}

class _CarrierCard extends StatelessWidget {
  const _CarrierCard({required this.cardBorder, required this.blue, required this.subtleText});

  final Color cardBorder;
  final Color blue;
  final Color subtleText;

  @override
  Widget build(BuildContext context) {
    final PackageDetailsController c = Get.find<PackageDetailsController>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
      ),
      child: Row(
        children: [
          const Text('Porteur', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        ],
      ),
    )._withBody(
      Column(
        children: [
          const SizedBox(height: 12),
          Obx(() {
            final info = c.carrier.value;
            return Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(info.avatarUrl), radius: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Color(0xFFFFB020), size: 18),
                          const SizedBox(width: 4),
                          Text('${info.rating.toStringAsFixed(0)} (${info.reviewsCount} avis)', style: TextStyle(color: subtleText)),
                          const SizedBox(width: 8),
                          if (info.verified)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFFDF5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.verified_rounded, color: Color(0xFF16A34A), size: 16),
                                  SizedBox(width: 4),
                                  Text('Certifié', style: TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: blue,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  onPressed: () => Get.snackbar('Message', 'Ouvrir la messagerie'),
                  child: const Text('Message'),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ContentsCard extends StatelessWidget {
  const _ContentsCard({required this.cardBorder, required this.subtleText});

  final Color cardBorder;
  final Color subtleText;

  @override
  Widget build(BuildContext context) {
    final PackageDetailsController c = Get.find<PackageDetailsController>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Contenant du colis', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 8),
          Obx(() => Text(c.contents.join(', '), style: TextStyle(color: subtleText))),
        ],
      ),
    );
  }
}

class _PhotosCard extends StatelessWidget {
  const _PhotosCard({required this.cardBorder});

  final Color cardBorder;

  @override
  Widget build(BuildContext context) {
    final PackageDetailsController c = Get.find<PackageDetailsController>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Photos du colis', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 12),
          Obx(() {
            return SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: c.photoUrls.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final url = c.photoUrls[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Image.network(url, fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

extension on Widget {
  Widget _withBody(Widget body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        this,
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: body,
        ),
      ],
    );
  }
}
