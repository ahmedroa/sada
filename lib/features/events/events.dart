import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/main_button.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  int _selectedPeriodIndex = 0;

  static const List<String> _periods = ['الأصدقاء', 'وصف الحديقه', 'الفعاليات', 'المبادرات'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPeriodOptions(context),
        const SizedBox(height: 16),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManager.green.withOpacity(.3),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.event, size: 24, color: ColorsManager.kPrimaryColor),
                Column(
                  children: [
                    Text(
                      'الاثنين ,7 جمادئ الاول 1446 \nحديقة الخزامى',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        MainButton(
                          text: 'مشاركة',
                          onTap: () {},
                          width: 130,
                          height: 40,
                          icon: Icon(Icons.upload_file, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        MainButton(
                          text: 'تذكير',
                          onTap: () {},
                          width: 130,
                          height: 40,
                          icon: Icon(Icons.notifications_none, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('img/rectangle.png', width: 120, height: 120, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('نبذه عن الحدث', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              Text(
                'انضموا إلينا و استمتعوا بمهرجان الجوف التراثي في منتزه الخزامى!🌿🎉 فعالية مميزة تحتفي بتراث المنطقة وثقافتها الغنية، مع عروض حية، أطعمة محلية، وأنشطة ممتعة لجميع أفراد العائلة. لا تفوتوا فرصة الاستمتاع بأجواء فريدة وتجربة لا تُنسى! 🔥✨',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              // Text(
              //   'موقع الحديقة على الخريطة',
              //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: ColorsManager.dark),
              // ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xff0D986A), borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.white),
                      Text(
                        'الموقع',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: _GardenMapBox(
                    initialPosition: const LatLng(29.9695, 40.2064), // موقع افتراضي - سكاكا، منطقة الجوف
                    gardenName: 'حديقة الخزامى',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodOptions(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final gap = (w * 0.01).clamp(4.0, 8.0);
    final fontSize = (w * 0.032).clamp(12.0, 15.0);
    final verticalPadding = (w * 0.028).clamp(10.0, 14.0);

    return Row(
      children: List.generate(_periods.length, (index) {
        final isSelected = index == _selectedPeriodIndex;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: index > 0 ? gap : 0, right: index < _periods.length - 1 ? gap : 0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() => _selectedPeriodIndex = index),
                borderRadius: BorderRadius.circular(24),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: verticalPadding),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xff0D986A) : ColorsManager.lighterGray,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _periods[index],
                    style: TextStyle(
                      fontSize: fontSize,
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

/// مربع خريطة يوضح موقع الحديقة على Google Map
class _GardenMapBox extends StatefulWidget {
  const _GardenMapBox({required this.initialPosition, required this.gardenName});

  final LatLng initialPosition;
  final String gardenName;

  @override
  State<_GardenMapBox> createState() => _GardenMapBoxState();
}

class _GardenMapBoxState extends State<_GardenMapBox> {
  static const double _defaultZoom = 15;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: widget.initialPosition, zoom: _defaultZoom),
      markers: {
        Marker(
          markerId: const MarkerId('garden'),
          position: widget.initialPosition,
          infoWindow: InfoWindow(title: widget.gardenName),
        ),
      },
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      liteModeEnabled: false,
    );
  }
}
