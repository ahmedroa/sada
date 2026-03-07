import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/main_button.dart';
import 'package:sada/features/events/widgets/garden_map_box.dart';

class GardenDescriptionTab extends StatelessWidget {
  const GardenDescriptionTab({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final imgSize = (w * 0.27).clamp(80.0, 130.0);
    final btnWidth = (w * 0.28).clamp(90.0, 130.0);
    final fontSize = (w * 0.036).clamp(12.0, 16.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManager.green.withOpacity(.3),
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.event, size: 20, color: ColorsManager.kPrimaryColor),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الاثنين ,7 جمادئ الاول 1446\nحديقة الخزامى',
                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Flexible(
                            child: MainButton(
                              text: 'مشاركة',
                              onTap: () {},
                              width: btnWidth,
                              height: 36,
                              icon: const Icon(Icons.upload_file, color: Colors.white, size: 16),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: MainButton(
                              text: 'تذكير',
                              onTap: () {},
                              width: btnWidth,
                              height: 36,
                              icon: const Icon(Icons.notifications_none, color: Colors.white, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'img/rectangle.png',
                    width: imgSize,
                    height: imgSize,
                    fit: BoxFit.cover,
                  ),
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
              const Text(
                'نبذه عن الحدث',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              const Text(
                'انضموا إلينا و استمتعوا بمهرجان الجوف التراثي في منتزه الخزامى! فعالية مميزة تحتفي بتراث المنطقة وثقافتها الغنية، مع عروض حية، أطعمة محلية، وأنشطة ممتعة لجميع أفراد العائلة. لا تفوتوا فرصة الاستمتاع بأجواء فريدة وتجربة لا تُنسى!',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsManager.kPrimaryColo,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.white),
                      SizedBox(width: 6),
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
                child: const SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: GardenMapBox(
                    initialPosition: LatLng(29.9695, 40.2064),
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
}
