import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/utils/card_shape_clipper.dart';
import 'package:sada/features/live/live_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const Color _cardGreen = Color(0xFFE6F5F4);
  static const Color _darkGreen = Color(0xFF1B5E4A);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: ColorsManager.backgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                _buildTopCard(context),
                // _buildPlantingCard(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: ColorsManager.kPrimaryColor, shape: BoxShape.circle),
                child: const Icon(Icons.person, color: Colors.white, size: 26),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('img/logo.png', width: 36, height: 36, fit: BoxFit.contain),
                  const SizedBox(width: 8),
                  Text(
                    'SADA',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _darkGreen),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(width: 1, height: 20, color: _darkGreen.withOpacity(0.5)),
                  ),
                  Text(
                    'سدى',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _darkGreen),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, color: ColorsManager.dark, size: 26),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'الصفحة الرئيسية',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: _darkGreen),
          ),
          const SizedBox(height: 8),
          Text(
            'أهلاً',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _darkGreen),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.location_on, size: 18, color: ColorsManager.dark),
              const SizedBox(width: 4),
              Text('سكاكا - اللقائط', style: TextStyle(fontSize: 14, color: ColorsManager.dark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopCard(BuildContext context) {
    return ClipPath(
      clipper: CardWithConcaveClipper(concaveRadius: 52),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        decoration: BoxDecoration(
          color: _cardGreen,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _metricItem(Icons.wb_sunny_outlined, 'الطقس', 'مشمس 30°'),
                      const SizedBox(height: 14),
                      _metricItem(Icons.people_outline, 'نسبة الإزدحام', '30%'),
                      const SizedBox(height: 14),
                      _metricItem(Icons.water_drop_outlined, 'استهلاك المياه', '80%'),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _metricItem(Icons.eco_outlined, 'صحة النباتات', '70-75%'),
                      const SizedBox(height: 14),
                      _metricItem(Icons.construction_outlined, 'حالة الألعاب', 'تحت الصيانه'),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.tune, color: ColorsManager.dark, size: 20),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'حديقة النخيل',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: ColorsManager.dark),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.notifications_outlined, color: ColorsManager.dark, size: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildParkImage(),
                      const SizedBox(height: 12),
                      _buildLiveViewButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricItem(IconData icon, String label, String value) {
    final isPercent = value.contains('%') && !value.startsWith('تحت');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: ColorsManager.dark, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: ColorsManager.dark, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  color: isPercent ? ColorsManager.kPrimaryColor : ColorsManager.dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildParkImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF87CEEB), ColorsManager.green, const Color(0xFF6B8E6B)],
          ),
        ),
        child: Center(child: Icon(Icons.park, size: 48, color: Colors.white.withOpacity(0.9))),
      ),
    );
  }

  Widget _buildLiveViewButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LiveView()));
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: _darkGreen, borderRadius: BorderRadius.circular(12)),
          child: const Center(
            child: Text(
              'Live View',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildPlantingCard(BuildContext context) {
  //   return Container(
  //     margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(24),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.08),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(24),
  //       child: Stack(
  //         children: [
  //           Container(
  //             height: 200,
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 begin: Alignment.centerRight,
  //                 end: Alignment.centerLeft,
  //                 colors: [
  //                   Colors.black.withOpacity(0.5),
  //                   ColorsManager.green.withOpacity(0.7),
  //                   _darkGreen.withOpacity(0.85),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             right: 0,
  //             top: 0,
  //             bottom: 0,
  //             left: 0,
  //             child: Padding(
  //               padding: const EdgeInsets.all(20),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const SizedBox.shrink(),
  //                   Text(
  //                     'ساهم في زرع 1000 نبته في حدائق منطقة الجوف',
  //                     style: const TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.white,
  //                       height: 1.3,
  //                     ),
  //                   ),
  //                   Row(
  //                     children: [
  //                       Material(
  //                         color: Colors.transparent,
  //                         child: InkWell(
  //                           onTap: () {},
  //                           borderRadius: BorderRadius.circular(12),
  //                           child: Container(
  //                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //                             decoration: BoxDecoration(
  //                               color: ColorsManager.dark.withOpacity(0.85),
  //                               borderRadius: BorderRadius.circular(12),
  //                             ),
  //                             child: const Text(
  //                               'شارك الآن',
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 15,
  //                                 fontWeight: FontWeight.w600,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       const Spacer(),
  //                       Row(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: List.generate(5, (i) {
  //                           return Container(
  //                             margin: const EdgeInsets.symmetric(horizontal: 2),
  //                             width: i == 0 ? 20 : 8,
  //                             height: 4,
  //                             decoration: BoxDecoration(
  //                               color: i == 0 ? Colors.white : Colors.white.withOpacity(0.5),
  //                               borderRadius: BorderRadius.circular(2),
  //                             ),
  //                           );
  //                         }),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
