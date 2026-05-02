import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sada/features/serach/garden_details.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('img/logo.png', width: 100, height: 100, fit: BoxFit.cover),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          // زر المفضلة في الأعلى
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xff0D986A).withOpacity(.76),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('img/floo.svg'),
                  const SizedBox(width: 10),
                  const Text(
                    'المفضلة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // قائمة المفضلة
          Expanded(
            child: uid == null
                ? const Center(child: Text('يرجى تسجيل الدخول'))
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('favorites')
                        .where('uid', isEqualTo: uid)
                        .snapshots(),
                    builder: (context, favSnap) {
                      if (favSnap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final favDocs = favSnap.data?.docs ?? [];

                      if (favDocs.isEmpty) {
                        return const Center(
                          child: Text(
                            'لا توجد حدائق في المفضلة',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        );
                      }

                      // جلب أسماء الحدائق المفضلة
                      final gardenNames = favDocs
                          .map((d) => (d.data() as Map)['gardenName'] as String? ?? '')
                          .where((n) => n.isNotEmpty)
                          .toList();

                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('gardens')
                            .get(),
                        builder: (context, gardenSnap) {
                          if (gardenSnap.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          // بناء map: name → بيانات الحديقة
                          final gardensMap = <String, Map<String, dynamic>>{};
                          for (final doc in gardenSnap.data?.docs ?? []) {
                            final data = doc.data() as Map<String, dynamic>;
                            final name = data['name'] as String? ?? '';
                            if (name.isNotEmpty) gardensMap[name] = data;
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 24),
                            itemCount: gardenNames.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 24),
                            itemBuilder: (context, i) {
                              final name = gardenNames[i];
                              final garden = gardensMap[name];
                              final image = garden?['image'] as String? ?? '';
                              final lat = (garden?['lat'] as num?)?.toDouble() ?? 0;
                              final lng = (garden?['lng'] as num?)?.toDouble() ?? 0;

                              return _FavoriteTile(
                                name: name,
                                image: image,
                                lat: lat,
                                lng: lng,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({
    required this.name,
    required this.image,
    required this.lat,
    required this.lng,
  });

  final String name;
  final String image;
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GardenDetails(
            name: name,
            distance: '',
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
            child: image.isNotEmpty
                ? Image.network(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) => progress == null
                        ? child
                        : Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xff0D986A)),
                            ),
                          ),
                    errorBuilder: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFFBB56),
                      ),
                    ),
                    const Icon(Icons.star_rate,
                        size: 13, color: Color(0xffFFBB56)),
                  ],
                ),
                const SizedBox(height: 10),
                const Icon(Icons.favorite, color: Colors.red, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() => Container(
        width: 100,
        height: 100,
        color: Colors.grey[200],
        child: const Icon(Icons.park_outlined, color: Colors.grey, size: 36),
      );
}
