import 'package:flutter/material.dart';


class AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onActionTap;
  final VoidCallback? onSettingsTap;
  final EdgeInsetsGeometry padding;

  const AppHeader({
    super.key,
    this.title = 'The Kinetic',
    this.subtitle = 'Gallery',
    this.actionText,
    this.onActionTap,
    this.onSettingsTap,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/avatar.png',
                  width: 38,
                  height: 38,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 38,
                      height: 38,
                      color: const Color(0xFFE6EEF9),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.person,
                        size: 20,
                        color: Color(0xFF4A6FFF),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              if (actionText != null) ...[
                GestureDetector(
                  onTap: onActionTap,
                  child: Text(
                    actionText!,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF5A5F),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              InkWell(
                onTap: onSettingsTap,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.settings_outlined,
                    size: 18,
                    color: Color(0xFF7E879C),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}