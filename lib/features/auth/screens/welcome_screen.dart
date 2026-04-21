import 'package:flutter/material.dart';
import 'package:bmi_app/features/auth/screens/login_screen.dart';
import 'package:bmi_app/features/auth/screens/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Overlay fade-in cho body.jpg
  late AnimationController _overlayFadeController;
  late Animation<double> _overlayFadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _overlayFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _overlayFadeAnimation = CurvedAnimation(
      parent: _overlayFadeController,
      curve: Curves.easeIn,
    );

    // Hiệu ứng ban đầu
    _fadeController.forward();
    _slideController.forward();
    _overlayFadeController.forward();
  }

  void _goToPage(int page) {
    if (page < 0 || page > 2) return;

    _fadeController.reset();
    _slideController.reset();
    if (page == 1) {
      _overlayFadeController.reset();
    }

    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );

    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      _fadeController.forward();
      _slideController.forward();
      if (page == 1) {
        _overlayFadeController.forward();
      }
    });

    setState(() => _currentPage = page);
  }

  void _goToLogin() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginScreen(),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _overlayFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: [
                  _buildPage1(),
                  _buildPage2(),
                  _buildPage3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedOpacity(
            opacity: _currentPage > 0 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: GestureDetector(
              onTap: _currentPage > 0
                  ? () => _goToPage(_currentPage - 1)
                  : null,
              child: const Icon(Icons.chevron_left,
                  size: 26, color: Color(0xFF2563EB)),
            ),
          ),
          _currentPage == 0
              ? const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vitality',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2563EB),
                    height: 1.1,
                  )),
              Text('Core',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2563EB),
                    height: 1.1,
                  )),
            ],
          )
              : const Text(
            'Editorial Athlete',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2563EB),
            ),
          ),
          TextButton(
            onPressed: _goToLogin,
            child: const Text(
              'BỎ QUA',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF94A3B8),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── PAGE 1 ───────────────────────────────────────────────────────────────
  Widget _buildPage1() {
    final isActive = _currentPage == 0;
    return FadeTransition(
      opacity: isActive ? _fadeAnimation : const AlwaysStoppedAnimation(1.0),
      child: SlideTransition(
        position: isActive
            ? _slideAnimation
            : const AlwaysStoppedAnimation(Offset.zero),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/runner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 18,
                        left: 18,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'LIVE MOTION DATA',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF334155),
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          height: 1.15,
                        ),
                        children: [
                          TextSpan(text: 'Làm chủ hành\ntrình\n'),
                          TextSpan(
                            text: 'sức khỏe.',
                            style: TextStyle(color: Color(0xFF2563EB)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Chào mừng đến với Vitality Core.\nTrải nghiệm dữ liệu sức khỏe\nnhư một tác phẩm nghệ thuật.',
                      style: TextStyle(
                        fontSize: 14.5,
                        color: Color(0xFF64748B),
                        height: 1.65,
                      ),
                    ),
                    const Spacer(),
                    _buildBottomNav(0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── PAGE 2 ───────────────────────────────────────────────────────────────
  Widget _buildPage2() {
    final isActive = _currentPage == 1;
    return FadeTransition(
      opacity: isActive ? _fadeAnimation : const AlwaysStoppedAnimation(1.0),
      child: SlideTransition(
        position: isActive
            ? _slideAnimation
            : const AlwaysStoppedAnimation(Offset.zero),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/body.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      FadeTransition(
                        opacity: isActive
                            ? _overlayFadeAnimation
                            : const AlwaysStoppedAnimation(1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: const Color(0xFF0F172A).withOpacity(0.45),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'THÀNH PHẦN CƠ THỂ',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF22C55E),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'TỐI ƯU',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  '22.4',
                                  style: TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1.0,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'BMI',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                _StatChip(
                                  icon: Icons.water_drop_outlined,
                                  label: 'LƯỢNG NƯỚC',
                                  value: '64%',
                                  color: const Color(0xFF3B82F6),
                                  dark: true,
                                ),
                                const SizedBox(width: 12),
                                _StatChip(
                                  icon: Icons.fitness_center_outlined,
                                  label: 'CƠ BẮP',
                                  value: '42kg',
                                  color: const Color(0xFF8B5CF6),
                                  dark: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'BƯỚC 02 — PHÂN TÍCH',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Theo dõi BMI\nchính xác.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Nhận phân tích chính xác về thành phần\ncơ thể với mô hình dữ liệu sinh trắc học\ncao cấp.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        height: 1.65,
                      ),
                    ),
                    const Spacer(),
                    _buildBottomNav(1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── PAGE 3 ───────────────────────────────────────────────────────────────
  Widget _buildPage3() {
    final isActive = _currentPage == 2;
    return FadeTransition(
      opacity: isActive ? _fadeAnimation : const AlwaysStoppedAnimation(1.0),
      child: SlideTransition(
        position: isActive
            ? _slideAnimation
            : const AlwaysStoppedAnimation(Offset.zero),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/raucu.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.restaurant_menu_rounded,
                                      color: Color(0xFF2563EB), size: 26),
                                  SizedBox(height: 6),
                                  Text(
                                    'CALO\nTỐI ƯU',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF2563EB),
                                      letterSpacing: 0.5,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE9FE),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.local_dining_rounded,
                                      color: Color(0xFF7C3AED), size: 26),
                                  SizedBox(height: 6),
                                  Text(
                                    'DINH\nDƯỠNG',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF7C3AED),
                                      letterSpacing: 0.5,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'TIẾN TRIỂN HÀNG NGÀY',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF94A3B8),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const Spacer(),
                        _MacroDot('V', const Color(0xFF3B82F6)),
                        const SizedBox(width: 4),
                        _MacroDot('P', const Color(0xFF22C55E)),
                        const SizedBox(width: 4),
                        _MacroDot('F', const Color(0xFFF59E0B)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.62,
                        minHeight: 6,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF2563EB)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '1.2k',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Text(
                            'CALO DỰ KIẾN',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(text: 'Đạt mục tiêu với\n'),
                          TextSpan(
                            text: 'thực đơn ',
                            style: TextStyle(color: Color(0xFF2563EB)),
                          ),
                          TextSpan(text: 'cá nhân\nhóa'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Kế hoạch dinh dưỡng riêng biệt phù hợp\nvới cường độ tập luyện và chỉ số cơ thể',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF64748B),
                        height: 1.6,
                      ),
                    ),
                    const Spacer(),
                    _buildBottomNav(2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── BOTTOM NAV ───────────────────────────────────────────────────────────
  Widget _buildBottomNav(int page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STEP 0${page + 1}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                page == 0
                    ? 'Giới thiệu'
                    : page == 1
                    ? 'Phân tích'
                    : 'Dinh dưỡng',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFCBD5E1),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Row(
            children: List.generate(3, (i) {
              final active = i == page;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOutCubic,
                margin: const EdgeInsets.only(right: 5),
                width: active ? 22 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF2563EB)
                      : const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              if (page < 2) {
                _goToPage(page + 1);
              } else {
                _goToLogin();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(
                horizontal: page < 2 ? 28 : 22,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    page < 2 ? 'Tiếp theo' : 'BẮT ĐẦU NGAY',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  if (page < 2) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward_rounded,
                        color: Colors.white, size: 18),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── HELPER WIDGETS ──────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool dark;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor =
    dark ? Colors.white.withOpacity(0.15) : color.withOpacity(0.08);
    final labelColor =
    dark ? Colors.white.withOpacity(0.7) : color.withOpacity(0.7);
    final valueColor = dark ? Colors.white : color;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: valueColor, size: 18),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: labelColor,
                    letterSpacing: 0.6,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroDot extends StatelessWidget {
  final String label;
  final Color color;

  const _MacroDot(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ),
    );
  }
}