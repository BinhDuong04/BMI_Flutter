import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/bmi_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  double _bmi = 22.7;
  double _prevBmi = 24.1;
  int _navIndex = 0;

  late AnimationController _gaugeCtrl;
  late Animation<double> _gaugeAnim;

  @override
  void initState() {
    super.initState();
    _gaugeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _gaugeAnim = CurvedAnimation(parent: _gaugeCtrl, curve: Curves.easeOutCubic);
    _gaugeCtrl.forward();
  }

  @override
  void dispose() {
    _gaugeCtrl.dispose();
    super.dispose();
  }

  void _onCalculate(double heightCm, double weightKg) {
    final newBmi = weightKg / pow(heightCm / 100, 2);
    setState(() {
      _prevBmi = _bmi;
      _bmi = double.parse(newBmi.toStringAsFixed(1));
    });
    _gaugeCtrl.forward(from: 0);
  }

  String _category(double bmi) {
    if (bmi < 18.5) return 'GẦY';
    if (bmi < 25) return 'CÂN NẶNG BÌNH THƯỜNG';
    if (bmi < 30) return 'THỪA CÂN';
    return 'BÉO PHÌ';
  }

  Color _color(double bmi) {
    if (bmi < 18.5) return const Color(0xFF3B82F6);
    if (bmi < 25) return const Color(0xFF10B981);
    if (bmi < 30) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  // ── Result card with animated gauge ──────────────────────────────────────
  Widget _buildResultCard() {
    final diff = _bmi - _prevBmi;
    final color = _color(_bmi);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecor(),
      child: Column(children: [
        // Gauge
        AnimatedBuilder(
          animation: _gaugeAnim,
          builder: (_, __) => SizedBox(
            width: 180,
            height: 180,
            child: CustomPaint(
              painter: _GaugePainter(bmi: _bmi * _gaugeAnim.value, color: color),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    (_bmi * _gaugeAnim.value).toStringAsFixed(1),
                    style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E)),
                  ),
                  Text(
                    _category(_bmi),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.5),
                  ),
                ]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Previous & target
        Row(children: [
          Expanded(child: _infoBox('TRƯỚC ĐÓ', _prevBmi.toStringAsFixed(1),
              diff >= 0 ? '+${diff.toStringAsFixed(1)}' : diff.toStringAsFixed(1),
              diff > 0 ? const Color(0xFFEF4444) : const Color(0xFF10B981))),
          const SizedBox(width: 12),
          Expanded(child: _infoBox('VÙNG MỤC TIÊU', '18.5 –', '24.9', const Color(0xFF10B981))),
        ]),
      ]),
    );
  }

  Widget _infoBox(String label, String value, String sub, Color subColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: const Color(0xFFF8F9FE), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey.shade500, letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(sub, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: subColor)),
          ),
        ]),
      ]),
    );
  }

  // ── Classification bar ───────────────────────────────────────────────────
  Widget _buildChartBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecor(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Tham chiếu phân loại',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Row(children: [
            Expanded(flex: 18, child: Container(height: 10, color: const Color(0xFF3B82F6))),
            Expanded(flex: 65, child: Container(height: 10, color: const Color(0xFF10B981))),
            Expanded(flex: 50, child: Container(height: 10, color: const Color(0xFFF59E0B))),
            Expanded(flex: 67, child: Container(height: 10, color: const Color(0xFFEF4444))),
          ]),
        ),
        const SizedBox(height: 8),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('18.5', style: TextStyle(fontSize: 11, color: Colors.grey)),
          Text('25.0', style: TextStyle(fontSize: 11, color: Colors.grey)),
          Text('30.0', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ]),
        const SizedBox(height: 4),
        const Row(children: [
          Expanded(child: Text('GẦY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6)))),
          Expanded(child: Text('BÌNH THƯỜNG', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF10B981)))),
          Expanded(child: Text('BÉO', textAlign: TextAlign.right, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFFEF4444)))),
        ]),
      ]),
    );
  }

  // ── Disclaimer ───────────────────────────────────────────────────────────
  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: const Color(0xFFDDE4FF), borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.info_outline_rounded, size: 18, color: Color(0xFF4361EE)),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'BMI là công cụ sàng lọc, không phải chẩn đoán y tế',
            style: TextStyle(fontSize: 13, color: Color(0xFF4361EE), fontWeight: FontWeight.w500, height: 1.4),
          ),
        ),
      ]),
    );
  }

  // ── Bottom nav ───────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    const items = [
      (Icons.home_rounded, 'Trang chủ'),
      (Icons.history_rounded, 'Lịch sử'),
      (Icons.bar_chart_rounded, 'Phân tích'),
      (Icons.flag_outlined, 'Mục tiêu'),
      (Icons.restaurant_menu_rounded, 'Định dưỡng'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final active = i == _navIndex;
              return GestureDetector(
                onTap: () => setState(() => _navIndex = i),
                behavior: HitTestBehavior.opaque,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(items[i].$1, size: 22, color: active ? const Color(0xFF4361EE) : Colors.grey.shade400),
                  const SizedBox(height: 4),
                  Text(items[i].$2,
                      style: TextStyle(fontSize: 10, fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                          color: active ? const Color(0xFF4361EE) : Colors.grey.shade400)),
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecor() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 3))],
  );

  // ── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FB),
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          const HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Máy tính BMI',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E))),
                const SizedBox(height: 4),
                Text('Theo dõi sự cân bằng cơ thể với độ chính xác cao',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500, height: 1.4)),
                const SizedBox(height: 20),
                BmiForm(onCalculate: _onCalculate),
                const SizedBox(height: 16),
                _buildDisclaimer(),
                const SizedBox(height: 16),
                _buildResultCard(),
                const SizedBox(height: 16),
                _buildChartBar(),
                const SizedBox(height: 24),
              ]),
            ),
          ),
          _buildBottomNav(),
        ]),
      ),
    );
  }
}

// ── Gauge painter ─────────────────────────────────────────────────────────
class _GaugePainter extends CustomPainter {
  final double bmi;
  final Color color;
  _GaugePainter({required this.bmi, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2 - 12;
    const start = pi * 0.75;
    const sweep = pi * 1.5;

    canvas.drawArc(Rect.fromCircle(center: c, radius: r), start, sweep, false,
        Paint()..color = const Color(0xFFEEEFF5)..style = PaintingStyle.stroke..strokeWidth = 14..strokeCap = StrokeCap.round);

    final fraction = ((bmi.clamp(10.0, 40.0)) - 10) / 30;
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), start, sweep * fraction, false,
        Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 14..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(_GaugePainter old) => old.bmi != bmi || old.color != color;
}