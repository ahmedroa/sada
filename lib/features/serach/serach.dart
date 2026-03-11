import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/app_text_form_field.dart';
import 'package:sada/features/serach/garden_details.dart';

class Serach extends StatefulWidget {
  const Serach({super.key});

  @override
  State<Serach> createState() => _SerachState();
}

class _SerachState extends State<Serach> {
  int _selectedPeriodIndex = 0;
  Position? _userPosition;

  static const List<String> _periods = ['الحدائق', 'الأشجار والنباتات', 'مواقف', 'الاكل والشراب'];

  static const List<Map<String, dynamic>> _gardens = [
    {'name': 'حديقة النخيل',   'lat': 29.995146, 'lng': 40.227533, 'image': 'img/test.jpg'},
    {'name': 'حديقة الخزامى',  'lat': 30.000179, 'lng': 40.218846, 'image': 'img/Group 6265788.png'},
    {'name': 'حديقة العزيزية', 'lat': 29.961350, 'lng': 40.187453, 'image': 'img/5345.png'},
    {'name': 'حديقة المبخرة',  'lat': 30.016377, 'lng': 40.221313, 'image': 'img/9843.png'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  Future<void> _fetchUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final isInSaudi = position.latitude >= 16.0 &&
          position.latitude <= 32.5 &&
          position.longitude >= 34.5 &&
          position.longitude <= 56.0;

      if (!isInSaudi) {
        if (mounted) {
          setState(() => _userPosition = Position(
            latitude: 29.955942,
            longitude: 40.209633,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            altitudeAccuracy: 0,
            heading: 0,
            headingAccuracy: 0,
            speed: 0,
            speedAccuracy: 0,
          ));
        }
        return;
      }

      if (mounted) setState(() => _userPosition = position);
    } catch (_) {}
  }

  String _calcDistance(double gardenLat, double gardenLng) {
    if (_userPosition == null) return '-- km';

    final meters = Geolocator.distanceBetween(
      _userPosition!.latitude,
      _userPosition!.longitude,
      gardenLat,
      gardenLng,
    );

    final km = meters / 1000;
    return km < 1
        ? '${meters.toStringAsFixed(0)} م'
        : '${km.toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            AppTextFormField(
              hintText: 'البحث',
              validator: (String? value) => null,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[100]!, width: .2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.search),
            ),
            const SizedBox(height: 16),
            _buildPeriodOptions(),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('الاقرب', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                const Icon(Icons.arrow_downward, size: 13),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _gardens.map((g) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildItem(
                        name: g['name'],
                        image: g['image'],
                        distance: _calcDistance(g['lat'], g['lng']),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   InkWell _buildItem({
    required String name,
    required String image,
    required String distance,
  }) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GardenDetails(name: name, distance: distance, image: image))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                          const Text('4.5', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Color(0xffFFBB56))),
          const Icon(Icons.star_rate, size: 13, color: Color(0xffFFBB56)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // const Icon(Icons.location_on_outlined, size: 13, color: ColorsManager.gray),
                    // const SizedBox(width: 2),
                    Text(
                      distance,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
      
        ],
      ),
    );
  }

  Widget _buildPeriodOptions() {
    return Row(
      children: List.generate(_periods.length, (index) {
        final isSelected = index == _selectedPeriodIndex;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index > 0 ? 4 : 0,
              right: index < _periods.length - 1 ? 4 : 0,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() => _selectedPeriodIndex = index),
                borderRadius: BorderRadius.circular(24),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xff0D986A) : ColorsManager.lighterGray,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _periods[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : ColorsManager.gray,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
