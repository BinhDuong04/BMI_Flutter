import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'register_screen.dart'; // ← Thêm import

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ── Chuyển sang trang đăng ký ──
  void _goToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // ── Tiêu đề ──
              const Text(
                'Chào mừng trở lại.',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1D26),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),

              // ── Phụ đề ──
              const Text(
                'Thư viện hiệu suất của bạn đang chờ đợi.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8E8EA9),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),

              // ── Trường Email ──
              _buildLabel('ĐIÁ CHI EMAIL'),
              const SizedBox(height: 8),
              _buildInputField(
                controller: _emailController,
                hintText: 'example@email.com',
                prefixIcon: _buildSvgIcon('assets/icons/mail.svg'),
                obscureText: false,
              ),
              const SizedBox(height: 24),

              // ── Trường Mật khẩu ──
              _buildLabel('MẬT KHẨU'),
              const SizedBox(height: 8),
              _buildInputField(
                controller: _passwordController,
                hintText: '••••••••',
                prefixIcon: _buildSvgIcon('assets/icons/lock.svg'),
                obscureText: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SvgPicture.asset(
                      _obscurePassword
                          ? 'assets/icons/eye-off.svg'
                          : 'assets/icons/eye.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF8E8EA9),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // ── Quên mật khẩu ──
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Forgot password
                  },
                  child: const Text(
                    'Quên mật khẩu?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4A6CF7),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // ── Nút Đăng nhập ──
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A6CF7),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  child: const Text('Đăng nhập'),
                ),
              ),
              const SizedBox(height: 32),

              // ── Divider "HOẶC TIẾP TỤC VỚI" ──
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFE4E6EF), thickness: 1.5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'HOẶC TIẾP TỤC VỚI',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8E8EA9).withValues(alpha: 0.8),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFE4E6EF), thickness: 1.5)),
                ],
              ),
              const SizedBox(height: 24),

              // ── Nút Google ──
              _buildSocialButton(
                label: 'Google',
                svgPath: 'assets/icons/google.svg',
                onTap: () {
                  // TODO: Google login
                },
              ),
              const SizedBox(height: 12),

              // ── Nút Apple ──
              _buildSocialButton(
                label: 'Apple',
                svgPath: 'assets/icons/apple.svg',
                onTap: () {
                  // TODO: Apple login
                },
              ),
              const SizedBox(height: 40),

              // ── Chưa có tài khoản? Đăng ký ──
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Chưa có tài khoản? ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8E8EA9),
                      ),
                    ),
                    GestureDetector(
                      onTap: _goToRegister, // ← Gọi hàm chuyển hướng
                      child: const Text(
                        'Đăng ký',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A6CF7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ────────────────────── Helper Widgets ──────────────────────

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF3D3D56),
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildSvgIcon(String path) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 12),
      child: SvgPicture.asset(
        path,
        width: 20,
        height: 20,
        colorFilter: const ColorFilter.mode(
          Color(0xFF8E8EA9),
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required Widget prefixIcon,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E6EF), width: 1.5),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF1A1D26),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFFC4C4D4),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20),
          suffixIcon: suffixIcon,
          suffixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required String svgPath,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF3D3D56),
          side: const BorderSide(color: Color(0xFFE4E6EF), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3D3D56),
              ),
            ),
          ],
        ),
      ),
    );
  }
}