import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<(IconData, String)> _items = [
    (Icons.home_outlined, 'TRANG\nCHỦ'),
    (Icons.history, 'LỊCH\nSỬ'),
    (Icons.show_chart_outlined, 'PHÂN\nTÍCH'),
    (Icons.track_changes_outlined, 'MỤC\nTIÊU'),
    (Icons.restaurant_outlined, 'DINH\nDƯỠNG'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FB),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(_items.length, (index) {
            final active = currentIndex == index;

            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _items[index].$1,
                        size: 18,
                        color: active
                            ? const Color(0xFF3B6BFF)
                            : const Color(0xFF98A2B3),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _items[index].$2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9,
                          height: 1.1,
                          fontWeight:
                          active ? FontWeight.w700 : FontWeight.w500,
                          color: active
                              ? const Color(0xFF3B6BFF)
                              : const Color(0xFF98A2B3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}