import 'package:flutter/material.dart';

import '../../../core/widgets/app_bottom_nav.dart';
import '../../../core/widgets/app_header.dart';
import '../../analysis/screens/analysis_screen.dart';
import '../../history/screens/history_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../nutrition/screens/nutrition_screen.dart';
import '../../profile/screens/account_screen.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  int _navIndex = 3;
  int _chartPeriodIndex = 2; // 0 tuần, 1 tháng, 2 năm

  void _onNavTap(int index) {
    if (_navIndex == index) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
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
        setState(() => _navIndex = 3);
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NutritionScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    _buildTitleBlock(),
                    const SizedBox(height: 14),
                    _buildProgressCard(),
                    const SizedBox(height: 14),
                    _buildAdviceCard(),
                    const SizedBox(height: 14),
                    _buildPlanCard(),
                    const SizedBox(height: 14),
                    _buildCurrentWeightCard(),
                    const SizedBox(height: 14),
                    _buildTargetWeightCard(),
                    const SizedBox(height: 14),
                    _buildRoadmapCard(),
                    const SizedBox(height: 28),
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

  Widget _buildTitleBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LỘ TRÌNH HIỆU SUẤT',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
            color: Color(0xFF3B6BFF),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Mục tiêu cá nhân',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            height: 0.95,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Các chỉ số sức khỏe của bạn được tính bây\nnhư những tác phẩm nghệ thuật. Theo dõi\nhành trình hướng tới sự cân bằng thể chất.',
          style: TextStyle(
            fontSize: 10.2,
            height: 1.5,
            color: Colors.black.withValues(alpha: 0.45),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE4E6FF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTopMetric(
                  label: 'TIẾN ĐỘ TỔNG THỂ',
                  value: '72',
                  suffix: '%',
                  valueColor: const Color(0xFF3B6BFF),
                ),
              ),
              Expanded(
                child: _buildTopMetric(
                  label: 'MỤC TIÊU',
                  value: '75.0',
                  suffix: ' kg',
                  valueColor: const Color(0xFF1A1A2E),
                  alignEnd: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildPhaseProgress(),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildBottomStat(
                  label: 'HIỆN TẠI',
                  value: '80.4',
                  unit: 'kg',
                ),
              ),
              Expanded(
                child: _buildBottomStat(
                  label: 'CÒN LẠI',
                  value: '5.4',
                  unit: 'kg',
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDF6EA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Vượt\nổn định',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1FA36B),
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopMetric({
    required String label,
    required String value,
    required String suffix,
    required Color valueColor,
    bool alignEnd = false,
  }) {
    return Column(
      crossAxisAlignment:
      alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: const Color(0xFF8F97B5),
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: valueColor,
                ),
              ),
              TextSpan(
                text: suffix,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: alignEnd ? const Color(0xFF1A1A2E) : valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhaseProgress() {
    return Column(
      children: [
        Container(
          height: 26,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: const Color(0xFFD0D5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: 0.72,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF5E90FF),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
              const Positioned.fill(
                child: Center(
                  child: Text(
                    'PHASE 02',
                    style: TextStyle(
                      fontSize: 7.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomStat({
    required String label,
    required String value,
    required String unit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 7.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: const Color(0xFF8F97B5),
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              TextSpan(
                text: ' $unit',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdviceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF2F6BFF),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2F6BFF).withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Đề xuất nổi bật',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tối ưu hóa BMI',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'BMI hiện tại: 28.2. Theo dõi, bạn cần giảm\n5.4kg để đạt chỉ số BMI lý tưởng 24.9 và tối ưu\nsức khỏe một cách bền vững.',
            style: TextStyle(
              fontSize: 9.6,
              height: 1.55,
              color: Colors.white.withValues(alpha: 0.88),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Xem thực đơn dinh dưỡng',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2F6BFF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5FA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TRẠNG THÁI',
                  style: TextStyle(
                    fontSize: 7.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: const Color(0xFF9AA1B5),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Chế độ giảm cân',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Color(0xFF7E879C),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentWeightCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E8FA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 8,
            top: 6,
            child: Icon(
              Icons.monitor_weight_outlined,
              size: 14,
              color: const Color(0xFF5E90FF).withValues(alpha: 0.80),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFF3B6BFF),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CÂN NẶNG HIỆN TẠI',
                style: TextStyle(
                  fontSize: 7.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: const Color(0xFF8F97B5),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '80.4',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    TextSpan(
                      text: ' kg',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7E879C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetWeightCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5FA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CÂN NẶNG MỤC TIÊU',
            style: TextStyle(
              fontSize: 7.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: const Color(0xFF8F97B5),
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: '75.0',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                TextSpan(
                  text: ' kg',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7E879C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildRoundControl(Icons.remove),
              const SizedBox(width: 10),
              Text(
                'ĐIỀU CHỈNH MỤC TIÊU',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.7,
                  color: const Color(0xFF7E879C),
                ),
              ),
              const Spacer(),
              _buildRoundControl(Icons.add),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoundControl(IconData icon) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        size: 12,
        color: const Color(0xFF5E90FF),
      ),
    );
  }

  Widget _buildRoadmapCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5FA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Lộ trình cân\nnặng',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              _buildSmallTab('Tuần', false),
              const SizedBox(width: 6),
              _buildSmallTab('Tháng', true),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'trong 30 ngày\nqua',
            style: TextStyle(
              fontSize: 8.5,
              height: 1.3,
              color: Colors.black.withValues(alpha: 0.45),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 130,
            child: CustomPaint(
              painter: _GoalBarsPainter(),
            ),
          ),
          const SizedBox(height: 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _RoadText('THÁNG 1'),
              _RoadText('THÁNG 2'),
              _RoadText('THÁNG 3'),
              _RoadText('HIỆN TẠI'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallTab(String text, bool active) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF2F6BFF) : const Color(0xFFE8EBF8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w800,
            color: active ? Colors.white : const Color(0xFF7E879C),
          ),
        ),
      ),
    );
  }
}

class _RoadText extends StatelessWidget {
  final String text;

  const _RoadText(this.text);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class _GoalBarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final baseY = size.height - 16;
    final startX = 8.0;
    const barWidth = 22.0;
    const gap = 10.0;

    final bars = [82.0, 78.0, 74.0, 70.0, 66.0];
    final colors = [
      const Color(0xFFD7E1F7),
      const Color(0xFFC9D7F5),
      const Color(0xFFBACDF4),
      const Color(0xFFA7C0F5),
      const Color(0xFF3B6BFF),
    ];

    for (int i = 0; i < bars.length; i++) {
      final x = startX + i * (barWidth + gap);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, baseY - bars[i], barWidth, bars[i]),
        const Radius.circular(8),
      );
      canvas.drawRRect(rect, Paint()..color = colors[i]);
    }

    final bubbleX = startX + 4 * (barWidth + gap) - 2;
    final bubbleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(bubbleX, baseY - 86, 34, 16),
      const Radius.circular(6),
    );
    canvas.drawRRect(bubbleRect, Paint()..color = const Color(0xFF3B6BFF));

    final tp = TextPainter(
      text: const TextSpan(
        text: '80.4',
        style: TextStyle(
          fontSize: 7.5,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(canvas, Offset(bubbleX + 6, baseY - 82));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}