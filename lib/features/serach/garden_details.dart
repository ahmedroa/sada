import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/main_button.dart';
import 'package:url_launcher/url_launcher.dart';

class GardenDetails extends StatefulWidget {
  final String name;
  final String distance;
  final String image;
  final double lat;
  final double lng;

  const GardenDetails({
    super.key,
    required this.name,
    required this.distance,
    required this.image,
    required this.lat,
    required this.lng,
  });

  @override
  State<GardenDetails> createState() => _GardenDetailsState();
}

class _GardenDetailsState extends State<GardenDetails> {
  Future<void> _openGoogleMaps() async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.lng}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  int _selectedStars = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'img/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Container(
              // height: 300,
              decoration: BoxDecoration(
                color: Color(0xffDEEAD8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff0D986A),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      '4.5',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star_rate,
                                      size: 13,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              widget.distance,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Image.network(
                        widget.image,
                        width: 280,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.favorite,
                              size: 24,
                              color: ColorsManager.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 18, left: 18),
              child: Text(
                'المرافق المتاحة',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18, left: 18),
              child: Divider(color: Colors.grey, height: 1),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('img/maki_toilet.png', width: 50, height: 50),
                SizedBox(width: 10),
                Image.asset('img/Parking.png', width: 50, height: 50),
                SizedBox(width: 10),
                Image.asset('img/FoodTruck.png', width: 50, height: 50),
                SizedBox(width: 10),
                Image.asset('img/Playground.png', width: 50, height: 50),
                SizedBox(width: 10),
                Image.asset('img/Stadium.png', width: 50, height: 50),
              ],
            ),
            Column(
              children: [
                // Container(
                //   margin: const EdgeInsets.symmetric(horizontal: 24),
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: Color(0xff3E7358),
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'حديقة الخزامى ',
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white,
                //         ),
                //       ),
                //       SizedBox(height: 8),
                //       Text(
                //         ' واحة طبيعية تجمع بين المساحات الخضراء، ممرات المشي، وأزهار الخزامى العطرة. المكان المثالي للاسترخاء، التنزه، والاستمتاع بالهواء النقي! ',
                //         style: TextStyle(
                //           fontSize: 13,
                //           color: Colors.white,
                //           height: 1.6,
                //         ),
                //       ),
                //       SizedBox(height: 12),
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.location_on,
                //             color: Color(0xff0D986A),
                //             size: 18,
                //           ),
                //           SizedBox(width: 4),
                //           Text(
                //             'الرياض، المملكة العربية السعودية',
                //             style: TextStyle(fontSize: 12, color: Colors.white),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 16),
                Text(
                  'قيم كيف ترى الحديقة!',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0D986A),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    final index = i + 1;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedStars = index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          index <= _selectedStars
                              ? Icons.star
                              : Icons.star_border,
                          color: const Color(0xff0D986A),
                          size: 26,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'أضف صورة لأجمل لقطة التقطتها!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                      size: 26,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                MainButton(
                  text: 'إرسال',
                  onTap: () {},
                  width: 160,
                  borderRadius: 30,
                  height: 40,
                ),
              ],
            ),

            // Spacer(),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: _openGoogleMaps,
                child: Container(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff0D986A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'الموقع',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
