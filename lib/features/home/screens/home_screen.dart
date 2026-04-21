import 'dart:math';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_bottom_nav.dart';
import '../../../core/widgets/app_header.dart';
import '../../history/screens/history_screen.dart';
import '../../analysis/screens/analysis_screen.dart';
import '../widgets/bmi_form.dart';
import '../../goal/screens/goal_screen.dart';
import '../../nutrition/screens/nutrition_screen.dart';
import '../../profile/screens/account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double _bmi = 22.7;
  double _prevBmi = 24.1;
  int _navIndex = 0;

  late final AnimationController _gaugeCtrl;
  late final Animation<double> _gaugeAnim;

  @override
  void initState() {
    super.initState();
    _gaugeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _gaugeAnim = CurvedAnimation(
      parent: _gaugeCtrl,
      curve: Curves.easeOutCubic,
    );
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

  void _onNavTap(int index) {
    if (_navIndex == index) return;

    switch (index) {
      case 0:
        setState(() => _navIndex = 0);
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HistoryScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AnalysisScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const GoalScreen()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NutritionScreen()),
        );
        break;
    }
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

  BoxDecoration _cardDecor() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 12,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFDDE4FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              size: 18,
              color: Color(0xFF4361EE),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'BMI là công cụ sàng lọc, không phải chẩn đoán y tế',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF4361EE),
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(
      String label,
      String value,
      String sub,
      Color subColor,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  sub,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: subColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    final diff = _bmi - _prevBmi;
    final color = _color(_bmi);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecor(),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _gaugeAnim,
            builder: (_, __) {
              final animatedBmi = _bmi * _gaugeAnim.value;

              return SizedBox(
                width: 180,
                height: 180,
                child: CustomPaint(
                  painter: _GaugePainter(
                    bmi: animatedBmi,
                    color: color,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          animatedBmi.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        Text(
                          _category(_bmi),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: color,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildInfoBox(
                  'TRƯỚC ĐÓ',
                  _prevBmi.toStringAsFixed(1),
                  diff >= 0
                      ? '+${diff.toStringAsFixed(1)}'
                      : diff.toStringAsFixed(1),
                  diff > 0
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoBox(
                  'VÙNG MỤC TIÊU',
                  '18.5 –',
                  '24.9',
                  const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tham chiếu phân loại',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                Expanded(
                  flex: 18,
                  child: Container(
                    height: 10,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                Expanded(
                  flex: 65,
                  child: Container(
                    height: 10,
                    color: const Color(0xFF10B981),
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Container(
                    height: 10,
                    color: const Color(0xFFF59E0B),
                  ),
                ),
                Expanded(
                  flex: 67,
                  child: Container(
                    height: 10,
                    color: const Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '18.5',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                '25.0',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                '30.0',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'GẦY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'BÌNH THƯỜNG',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF10B981),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'BÉO',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEF4444),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FB),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppHeader(
              onSettingsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AccountScreen()),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Máy tính BMI',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Theo dõi sự cân bằng cơ thể với độ chính xác cao',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    BmiForm(onCalculate: _onCalculate),
                    const SizedBox(height: 16),
                    _buildDisclaimer(),
                    const SizedBox(height: 16),
                    _buildResultCard(),
                    const SizedBox(height: 16),
                    _buildChartBar(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            AppBottomNav(
              currentIndex: _navIndex,
              onTap: _onNavTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double bmi;
  final Color color;

  _GaugePainter({
    required this.bmi,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;

    const startAngle = pi * 0.75;
    const sweepAngle = pi * 1.5;

    final bgPaint = Paint()
      ..color = const Color(0xFFEEEFF5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final valuePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    final fraction = (bmi.clamp(10.0, 40.0) - 10.0) / 30.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * fraction,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.bmi != bmi || oldDelegate.color != color;
  }
}