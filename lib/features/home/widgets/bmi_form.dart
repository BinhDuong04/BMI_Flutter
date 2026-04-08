import 'package:flutter/material.dart';

class BmiForm extends StatefulWidget {
  final void Function(double heightCm, double weightKg) onCalculate;
  const BmiForm({super.key, required this.onCalculate});

  @override
  State<BmiForm> createState() => _BmiFormState();
}

class _BmiFormState extends State<BmiForm> {
  bool isCm = true;
  bool isKg = true;
  final _heightCtrl = TextEditingController(text: '178');
  final _weightCtrl = TextEditingController(text: '72');

  @override
  void dispose() {
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final h = double.tryParse(_heightCtrl.text);
    final w = double.tryParse(_weightCtrl.text);
    if (h == null || w == null) return;
    widget.onCalculate(isCm ? h : h * 30.48, isKg ? w : w * 0.453592);
  }

  Widget _toggleChip(String left, String right, bool isLeftSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        decoration: BoxDecoration(color: const Color(0xFFEEEFF5), borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          _chip(left, isLeftSelected),
          _chip(right, !isLeftSelected),
        ]),
      ),
    );
  }

  Widget _chip(String label, bool active) => AnimatedContainer(
    duration: const Duration(milliseconds: 180),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: active ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(7),
      boxShadow: active ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)] : [],
    ),
    child: Text(label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? const Color(0xFF1A1A2E) : Colors.grey)),
  );

  Widget _inputCard(String label, TextEditingController ctrl, String unit, Widget toggle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey.shade500, letterSpacing: 0.8)),
          toggle,
        ]),
        const SizedBox(height: 8),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
            child: TextField(
              controller: ctrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E)),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(unit, style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
          ),
        ]),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _inputCard('CHIỀU CAO', _heightCtrl, isCm ? 'cm' : 'ft',
          _toggleChip('CM', 'FT', isCm, () => setState(() => isCm = !isCm))),
      const SizedBox(height: 12),
      _inputCard('CÂN NẶNG', _weightCtrl, isKg ? 'kg' : 'lb',
          _toggleChip('KG', 'LB', isKg, () => setState(() => isKg = !isKg))),
      const SizedBox(height: 20),
      SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: _calculate,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4361EE),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Tính BMI', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ),
    ]);
  }
}