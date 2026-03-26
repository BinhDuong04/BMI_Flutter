import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroupInfoPage(),
    );
  }
}

class GroupInfoPage extends StatelessWidget {
  const GroupInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giới thiệu nhóm'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Chuyên đề 2',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          const Text(
            'Đề tài: Ứng dụng tính chỉ số BMI',
            style: TextStyle(fontSize: 18),
          ),

          const Text(
            '🏫 Lớp: DCCNTT13.10.4',
            style: TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 20),
          const Divider(),

          const Text(
            'Trưởng nhóm:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          memberItem(
            'Dương Lý Bình',
            '20220704',
            'assets/images/Binh.jpg',
            isLeader: true,
          ),

          const SizedBox(height: 20),

          const Text(
            '👥 Thành viên:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          memberItem(
            'Hoàng Mậu Phong',
            '20220535',
            'assets/images/Phong.jpg',
          ),
        ],
      ),
    );
  }

  Widget memberItem(String name, String id, String imagePath,
      {bool isLeader = false}) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(name),
        subtitle: Text('MSSV: $id'),
        trailing: isLeader
            ? const Icon(Icons.star, color: Colors.orange)
            : null,
      ),
    );
  }
}