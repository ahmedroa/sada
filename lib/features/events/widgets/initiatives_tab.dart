import 'package:flutter/material.dart';
import 'package:sada/core/widgets/main_button.dart';

class InitiativesTab extends StatefulWidget {
  const InitiativesTab({super.key});

  static final ValueNotifier<bool> inDetail = ValueNotifier(false);

  @override
  State<InitiativesTab> createState() => _InitiativesTabState();
}

class _InitiativesTabState extends State<InitiativesTab> {
  String? _selectedTitle;

  @override
  void initState() {
    super.initState();
    InitiativesTab.inDetail.addListener(_onDetailChanged);
  }

  @override
  void dispose() {
    InitiativesTab.inDetail.removeListener(_onDetailChanged);
    super.dispose();
  }

  void _onDetailChanged() {
    if (!InitiativesTab.inDetail.value && _selectedTitle != null) {
      setState(() => _selectedTitle = null);
    }
  }

  static const _items = [
    {
      'title': 'التوعية البيئية',
      'image': 'img/image99999.png',
      'button': 'انضم الان',
    },
    {'title': 'إعادة التدوير', 'image': 'img/imag0010.png', 'button': 'شارك'},
    {'title': 'الزراعة و التشجير', 'image': 'img/dsak.png', 'button': 'أزرعها'},
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _selectedTitle == null ? _buildList() : _buildDetail(),
    );
  }

  Widget _buildList() {
    return Padding(
      key: const ValueKey('list'),
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('img/image1111.png', fit: BoxFit.cover),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 34),
                child: Text(
                  'تطوع الان !',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff0D986A),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ..._items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _builtItem(
                  title: item['title']!,
                  image: item['image']!,
                  titleButton: item['button']!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail() {
    return LayoutBuilder(
      key: const ValueKey('detail'),
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _selectedTitle ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0D986A),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // الصور
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'img/232323.png',
                    width: double.infinity,
                    height: w * 0.45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'img/21121.png',
                      width: w * 0.65,
                      height: w * 0.45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'img/2222123.png',
                    width: double.infinity,
                    height: w * 0.45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _builtItem({
    required String title,
    required String image,
    required String titleButton,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final imageWidth = width * 0.42;
        final imageHeight = imageWidth * 0.55;
        final buttonWidth = width * 0.28;
        final buttonHeight = width * 0.1;
        final fontSize = width * 0.042;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: width * 0.05,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: width * 0.03),
                  MainButton(
                    text: titleButton,
                    onTap: () {
                      setState(() => _selectedTitle = title);
                      InitiativesTab.inDetail.value = true;
                    },
                    width: buttonWidth,
                    height: buttonHeight,
                    fontSize: fontSize * 0.9,
                    fontWeight: FontWeight.bold,
                    borderRadius: 20,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
