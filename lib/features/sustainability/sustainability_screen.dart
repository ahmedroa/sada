import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/main_button.dart';
import 'package:sada/features/sustainability/indicators_screen.dart';

class SustainabilityScreen extends StatefulWidget {
  const SustainabilityScreen({super.key});

  @override
  State<SustainabilityScreen> createState() => _SustainabilityScreenState();
}

class _SustainabilityScreenState extends State<SustainabilityScreen> {
  int _selectedTab = 1;
  String _selectedGarden = 'حديقة الخزامى';
  final Set<int> _expandedSections = {};

  final List<String> _gardens = [
    'حديقة الخزامى',
    'حديقة النخيل',
    'حديقة الورود',
  ];

  final List<_RatingSection> _sections = [
    _RatingSection(
      title: 'الإستدامة المجتمعية',
      items: [
        'تنوع الأنشطة المجتمعية',
        'مستوى التفاعل والحضور',
        'المبادرات التطوعية',
        'مستوى الأمان',
      ],
    ),
    _RatingSection(
      title: 'الصيانة الدورية',
      items: [
        'نظافة المرافق العامة',
        'الحالة العامة للحديقة',
        'سلامة مناطق اللعب',
        'الإضاءة الليلية',
      ],
    ),
    _RatingSection(
      title: 'الأشجار والمساحات الخضراء',
      items: [
        'تنوع النباتات',
        'العناية بالنباتات',
        'كثافة الأشجار',
        'نظافة المساحات الخضراء',
      ],
    ),
  ];

  // ratings[sectionIndex][itemIndex] = selected value (1-5) or 0
  late List<List<int>> _ratings;

  @override
  void initState() {
    super.initState();
    _ratings = _sections
        .map((s) => List<int>.filled(s.items.length, 0))
        .toList();
  }

  void _onSubmit() {
    // TODO: handle submit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 16),

          _buildTabs(),
          Expanded(
            child: _selectedTab == 0 ? _buildRatingTab() : IndicatorsContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabItem('مؤشرات الإستدامة', 1),
          const SizedBox(width: 8),
          _buildTabItem('تقييم الحدائق', 0),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff0D986A) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : ColorsManager.gray,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: Text(
            'ساهم في تحسين مؤشرات الإستدامة',
            style: TextStyle(fontSize: 13, color: ColorsManager.primary),
          ),
        ),
        _buildGardenDropdown(),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
            itemCount: _sections.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) => _buildSection(index),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: MainButton(
            text: 'إرسال',
            onTap: _onSubmit,
            width: 130,
            height: 35,
            borderRadius: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildGardenDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsManager.lighterGray),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedGarden,
                isDense: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                onChanged: (val) => setState(() => _selectedGarden = val!),
                items: _gardens
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(int sectionIndex) {
    final section = _sections[sectionIndex];
    final isExpanded = _expandedSections.contains(sectionIndex);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xffDEEAD8),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              isExpanded
                  ? _expandedSections.remove(sectionIndex)
                  : _expandedSections.add(sectionIndex);
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: isExpanded
                    ? const BorderRadius.vertical(top: Radius.circular(14))
                    : BorderRadius.circular(14),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xff0D986A),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: List.generate(
                  section.items.length,
                  (itemIndex) => _buildRatingRow(sectionIndex, itemIndex),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(int sectionIndex, int itemIndex) {
    final label = _sections[sectionIndex].items[itemIndex];
    final selected = _ratings[sectionIndex][itemIndex];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
          Row(
            children: List.generate(5, (i) {
              final value = i + 1;
              final isSelected = value <= selected;
              return GestureDetector(
                onTap: () =>
                    setState(() => _ratings[sectionIndex][itemIndex] = value),
                child: Container(
                  margin: const EdgeInsets.only(left: 6),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? const Color(0xff0D986A)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xff0D986A)
                          : ColorsManager.lightGray,
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$value',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : ColorsManager.gray,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _RatingSection {
  final String title;
  final List<String> items;

  const _RatingSection({required this.title, required this.items});
}
