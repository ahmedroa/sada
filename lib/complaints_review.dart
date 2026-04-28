import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/main_button.dart';
import 'package:sada/features/municipality/complaints_pane.dart';
import 'package:sada/features/municipality/suggestions_pane.dart';

class ComplaintsReview extends StatefulWidget {
  const ComplaintsReview({super.key});

  @override
  State<ComplaintsReview> createState() => _ComplaintsReviewState();
}

class _ComplaintsReviewState extends State<ComplaintsReview> {
  /// false = الشكاوي، true = الاقتراحات
  bool _suggestionsTab = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_forward_ios_rounded,
        //     size: 18,
        //     color: ColorsManager.dark,
        //   ),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: Image.asset(
          'img/logo.png',
          width: 100,
          height: 52,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _tabChip(
                    label: 'الشكاوي',
                    selected: !_suggestionsTab,
                    onTap: () => setState(() => _suggestionsTab = false),
                  ),
                  const SizedBox(width: 10),
                  _tabChip(
                    label: 'الاقتراحات',
                    selected: _suggestionsTab,
                    onTap: () => setState(() => _suggestionsTab = true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: _suggestionsTab
                  ? const SuggestionsPane(
                      key: ValueKey('sug'),
                      shrinkWrap: true,
                    )
                  : const ComplaintsPane(
                      key: ValueKey('com'),
                      shrinkWrap: true,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140, right: 140),
              child: MainButton(
                color: Color(0xff34C759),
                text: 'عرض المزيد',
                onTap: () {},
                height: 52,
                borderRadius: 12,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: selected ? const Color(0xff0D986A) : const Color(0xffF4F4F4),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : ColorsManager.gray,
            ),
          ),
        ),
      ),
    );
  }
}
