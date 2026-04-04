import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class GardenService {
  static List<Map<String, dynamic>>? _cache;

  static Future<List<Map<String, dynamic>>> fetchGardens() async {
    if (_cache != null) return _cache!;

    final snapshot =
        await FirebaseFirestore.instance.collection('gardens').get();

    _cache = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'name': data['name'] ?? '',
        'lat': (data['lat'] as num).toDouble(),
        'lng': (data['lng'] as num).toDouble(),
      };
    }).toList();

    debugPrint('Loaded ${_cache!.length} gardens from Firestore');
    return _cache!;
  }

  static String findNearest(
    List<Map<String, dynamic>> gardens,
    double userLat,
    double userLng,
  ) {
    Map<String, dynamic> nearest = gardens[0];
    double minDist = _squaredDistance(userLat, userLng, gardens[0]['lat'], gardens[0]['lng']);

    for (final g in gardens.skip(1)) {
      final d = _squaredDistance(userLat, userLng, g['lat'], g['lng']);
      if (d < minDist) {
        minDist = d;
        nearest = g;
      }
    }
    return nearest['name'] as String;
  }

  static double _squaredDistance(double lat1, double lng1, double lat2, double lng2) {
    final dlat = lat1 - lat2;
    final dlng = lng1 - lng2;
    return dlat * dlat + dlng * dlng;
  }
}
