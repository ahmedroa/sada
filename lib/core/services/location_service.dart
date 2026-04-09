import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<String> fetchCityName() async {
    try {
      // 1. التحقق من تفعيل الخدمة والإذن
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return 'خدمة الموقع معطلة';

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied)
          return 'لم يتم منح إذن الموقع';
      }
      if (permission == LocationPermission.deniedForever) {
        return 'الموقع محظور، يرجى تفعيله من الإعدادات';
      }

      // 2. جلب الإحداثيات الحالية
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      // 3. تحويل الإحداثيات إلى اسم مدينة
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 8));

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        if (p.isoCountryCode != 'SA') return 'الجوف المملكة العربية السعودية';
        final city = p.locality?.isNotEmpty == true
            ? p.locality!
            : p.subAdministrativeArea ?? '';
        return '$city، المملكة العربية السعودية';
      }

      return 'تعذر تحديد الموقع';
    } catch (_) {
      return 'تعذر تحديد الموقع';
    }
  }
}
