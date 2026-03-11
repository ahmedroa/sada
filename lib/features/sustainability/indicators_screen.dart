import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';

const _kGreen = Color(0xff0D986A);

class IndicatorsContent extends StatefulWidget {
  const IndicatorsContent({super.key});

  @override
  State<IndicatorsContent> createState() => _IndicatorsContentState();
}

class _IndicatorsContentState extends State<IndicatorsContent> {
  String? _selectedGarden;

  static const _gardens = ['حديقة الخزامى', 'حديقة النخيل', 'حديقة الورود'];

  static const _indicatorLabels = ['المشاركة المجتمعية', 'الصيانة الدورية', 'الأشجار والمساحات الخضراء'];

  // القيم القابلة للتعديل — ستُرسل للداتابيس لاحقاً
  final Map<String, double> _scores = {
    'المشاركة المجتمعية': 9.7,
    'الصيانة الدورية': 10.0,
    'الأشجار والمساحات الخضراء': 9.9,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          _buildHeader(),
          const SizedBox(height: 16),
          _buildGardenDropdown(),
          const SizedBox(height: 8),
          _buildWaveChart(),
          const SizedBox(height: 24),
          _buildIndicatorList(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Column(
      children: const [
        Text(
          'مؤشرات إستدامة الحدائق',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff1A3C2E)),
        ),
        SizedBox(height: 6),
        Text('تقييم الأداء البيئي والإجتماعي', style: TextStyle(fontSize: 18, color: Color(0xff224214))),
      ],
    );
  }

  // ─── Dropdown ─────────────────────────────────────────────────────────────

  Widget _buildGardenDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(color: const Color(0xffF0EEF8), borderRadius: BorderRadius.circular(30)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedGarden,
            isExpanded: true,
            hint: const Text(
              'اختر الحديقة',
              textAlign: TextAlign.right,
              style: TextStyle(color: ColorsManager.gray, fontSize: 14),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            onChanged: (val) => setState(() => _selectedGarden = val),
            items: _gardens
                .map(
                  (g) => DropdownMenuItem(
                    value: g,
                    child: Text(g, textAlign: TextAlign.right),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  // ─── Wave Chart ───────────────────────────────────────────────────────────

  Widget _buildWaveChart() {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: CustomPaint(painter: _WaveChartPainter()),
    );
  }

  // ─── Indicators ───────────────────────────────────────────────────────────

  Widget _buildIndicatorList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: _indicatorLabels.map((label) => _buildIndicatorRow(label)).toList()),
    );
  }

  Widget _buildIndicatorRow(String label) {
    final score = _scores[label]!;
    final showBubble = label == 'الصيانة الدورية';

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Stack(
            clipBehavior: Clip.none,
            children: [
              _buildDraggableBar(label, score),
              if (showBubble)
                Positioned(
                  bottom: 36,
                  left: 40,
                  child: _buildSpeechBubble('مكان مريح\nوجاهز لك!\nتجربة مربحة\nبنتظارك!!'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableBar(String label, double score) {
    const trackHeight = 22.0;
    const barHeight = 36.0;
    const badgeWidth = 56.0;
    const verticalPad = (barHeight - trackHeight) / 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final filledWidth = (score / 10.0) * totalWidth;
        // badge left edge: ends where fill ends, clamped so it stays inside
        final badgeLeft = (filledWidth - badgeWidth).clamp(0.0, totalWidth - badgeWidth);

        return SizedBox(
            height: barHeight,
            child: Stack(
              children: [
                // ── Track background ──────────────────────────────────────
                Positioned(
                  left: 0,
                  right: 0,
                  top: verticalPad,
                  height: trackHeight,
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xffE8F5EE), borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                // ── Filled portion ────────────────────────────────────────
                Positioned(
                  left: 0,
                  top: verticalPad,
                  height: trackHeight,
                  width: filledWidth.clamp(0.0, totalWidth),
                  child: Container(
                    decoration: BoxDecoration(color: _kGreen, borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                // ── Score badge (moves with fill) ─────────────────────────
                Positioned(
                  left: badgeLeft,
                  top: 0,
                  bottom: 0,
                  width: badgeWidth,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: _kGreen,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 2)),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        score % 1 == 0 ? score.toInt().toString() : score.toStringAsFixed(1),
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        );
      },
    );
  }

  Widget _buildSpeechBubble(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border.all(color: _kGreen, width: 1.2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, color: Colors.black87, height: 1.5),
      ),
    );
  }

  /// استخدم هذا للحصول على القيم قبل الإرسال للداتابيس
  Map<String, double> get currentScores => Map.unmodifiable(_scores);
}

// ─── Wave Chart Painter ───────────────────────────────────────────────────────

class _WaveChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = _kGreen
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_kGreen.withOpacity(0.25), _kGreen.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final points = _generateWavePoints(size);

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    final fillPath = Path()..moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final cp1 = Offset((points[i].dx + points[i + 1].dx) / 2, points[i].dy);
      final cp2 = Offset((points[i].dx + points[i + 1].dx) / 2, points[i + 1].dy);
      linePath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, points[i + 1].dx, points[i + 1].dy);
      fillPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, points[i + 1].dx, points[i + 1].dy);
    }

    fillPath
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  List<Offset> _generateWavePoints(Size size) {
    const count = 20;
    final random = Random(42);
    return List.generate(count, (i) {
      final x = size.width * i / (count - 1);
      final baseY = size.height * 0.45;
      final amplitude = size.height * 0.28;
      final noise = (random.nextDouble() - 0.5) * amplitude;
      final wave = sin(i * 0.9) * (amplitude * 0.5);
      return Offset(x, baseY + wave + noise);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
