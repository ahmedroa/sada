import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Map<String, dynamic>> _gardens = [];
  bool _isLoadingGardens = true;

  static const List<String> _periods = [
    'الحدائق',
    'الأشجار والنباتات',
    'مواقف',
    'الاكل والشراب',
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
    _fetchGardens();
  }

  Future<void> _fetchGardens() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('gardens')
          .get();
      if (mounted) {
        setState(() {
          _gardens = snapshot.docs.map((doc) => doc.data()).toList();
          _isLoadingGardens = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingGardens = false);
    }
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

      final isInSaudi =
          position.latitude >= 16.0 &&
          position.latitude <= 32.5 &&
          position.longitude >= 34.5 &&
          position.longitude <= 56.0;

      if (!isInSaudi) {
        if (mounted) {
          setState(
            () => _userPosition = Position(
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
            ),
          );
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
                const Text(
                  'الاقرب',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const Icon(Icons.arrow_downward, size: 13),
              ],
            ),
            const SizedBox(height: 16),
            // loading gardens
            Expanded(
              child: _isLoadingGardens
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff0D986A),
                      ),
                    )
                  // no gardens
                  : _gardens.isEmpty
                  ? const Center(
                      child: Text(
                        'لا توجد حدائق',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: _gardens.map((g) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildItem(
                              name: g['name'] ?? '',
                              image: g['image'] ?? '',
                              lat: (g['lat'] as num).toDouble(),
                              lng: (g['lng'] as num).toDouble(),
                              distance: _calcDistance(
                                (g['lat'] as num).toDouble(),
                                (g['lng'] as num).toDouble(),
                              ),
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
    required double lat,
    required double lng,
  }) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GardenDetails(
            name: name,
            distance: distance,
            image: image,
            lat: lat,
            lng: lng,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xff0D986A),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    const Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFFBB56),
                      ),
                    ),
                    const Icon(
                      Icons.star_rate,
                      size: 13,
                      color: Color(0xffFFBB56),
                    ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xff0D986A)
                        : ColorsManager.lighterGray,
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
