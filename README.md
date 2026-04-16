# CHUYÊN ĐỀ 2

## 👥 Thành viên nhóm

1. **Dương Lý Bình**  
   - MSSV: 20220704  
   - Lớp: DCCNTT13.10.4  
   - Vai trò: Trưởng nhóm  

2. **Hoàng Mậu Phong**  
   - MSSV: 20220535  
   - Lớp: DCCNTT13.10.4  


## Đề tài
**Ứng dụng tính chỉ số BMI**

## 📖 Giới thiệu
Ứng dụng **BMI Calculator** được phát triển bằng **Flutter**, giúp người dùng nhanh chóng tính toán và đánh giá chỉ số khối cơ thể (BMI) dựa trên chiều cao và cân nặng. Ứng dụng cung cấp giao diện trực quan, kết quả chính xác kèm theo phân loại tình trạng sức khỏe theo chuẩn WHO, phù hợp cho mục đích học tập, đồ án hoặc phát triển sản phẩm cá nhân.

## ✨ Tính năng chính
-  Nhập liệu chiều cao (cm) và cân nặng (kg) trực quan
-  Tính BMI tự động theo công thức chuẩn: `BMI = Cân nặng(kg) / [Chiều cao(m)]²`
-  Phân loại kết quả: Gầy, Bình thường, Thừa cân, Béo phì độ I/II/III
-  Giao diện Material Design, responsive trên mọi kích thước màn hình
-  Hỗ trợ chế độ sáng/tối (Light/Dark mode)
-  Hiển thị gợi ý sức khỏe & khoảng cân nặng lý tưởng tương ứng

## 🛠 Công nghệ & Môi trường phát triển
| Thành phần | Phiên bản khuyến nghị |
|------------|------------------------|
| **Framework** | Flutter SDK ≥ 3.10 |
| **Ngôn ngữ** | Dart ≥ 3.0 |
| **IDE** | Android Studio (2023.1 Hedgehog trở lên) |
| **JDK** | OpenJDK / JetBrains JDK 11 hoặc 17 |
| **Android SDK** | API 33+ (Android 13) |
| **Hệ điều hành** | Windows 10/11, macOS, Linux |

## 📋 Yêu cầu hệ thống
- Đã cài đặt và cấu hình **Flutter** & **Dart**
- Đã cài đặt **Android Studio** với plugin `Flutter` và `Dart`
- Đã thiết lập **Android SDK** và tạo Emulator (AVD) hoặc kết nối thiết bị thật
- Kết nối Internet ổn định (cho lần chạy đầu tiên để tải dependencies)

## 🚀 Hướng dẫn cài đặt & chạy ứng dụng

### 1️⃣ Clone mã nguồn
```bash
https://github.com/BinhDuong04/BMI_Flutter.git
```

### 2️⃣ Kiểm tra môi trường Flutter
Mở terminal tại thư mục dự án và chạy:
bash
1
 Đảm bảo các mục Android toolchain và Connected device hiển thị dấu tích xanh. Nếu thiếu, làm theo hướng dẫn của flutter doctor để cài đặt/cấu hình.
### 3️⃣ Mở dự án bằng Android Studio
Mở Android Studio → File → Open → Chọn thư mục bmi-calculator-flutter
Android Studio sẽ tự động nhận diện cấu hình Flutter. Đợi IDE sync Gradle và index dự án.
### 4️⃣ Cài đặt dependencies
Trong terminal của Android Studio (hoặc CMD/PowerShell tại thư mục gốc), chạy:
```bash
flutter pub get
```

### 5️⃣ Chạy ứng dụng
Mở Device Manager trong Android Studio → Khởi động Emulator hoặc kết nối điện thoại thật (bật USB Debugging)
Chọn thiết bị ở góc trên bên phải IDE
Nhấn nút Run (▶️) hoặc dùng lệnh:
```bash
flutter run
```

📁 Cấu trúc thư mục chính
```bash
bmi-calculator-flutter/
├── android/          # Cấu hình native Android & Gradle
├── ios/              # Cấu hình native iOS (nếu build cho iOS)
├── lib/              # Mã nguồn Flutter chính
│   ├── main.dart     # Điểm bắt đầu & cấu hình MaterialApp
│   ├── screens/      # Các màn hình giao diện (Home, Result, History...)
│   ├── widgets/      # Widget tái sử dụng (InputCard, Button, Gauge...)
│   └── utils/        # Hàm tiện ích, công thức tính, phân loại BMI
├── assets/           # Hình ảnh, icon, font tùy chỉnh
├── pubspec.yaml      # Khai báo dependencies, assets, metadata
└── README.md         # Tài liệu hướng dẫn này
```
📝 Lưu ý & Đóng góp
⚠️ Ứng dụng chỉ mang tính chất tham khảo. Kết quả BMI không thay thế chẩn đoán hoặc tư vấn y tế chuyên nghiệp.
🔧 Trước khi push code, hãy chạy flutter analyze và flutter format . để đảm bảo chuẩn code.
🤝 Mọi đóng góp (bug report, tính năng mới, cải tiến UI/UX) vui lòng tạo Issue hoặc gửi Pull Request.
📄 License
Dự án được phân phối dưới giấy phép MIT. Xem file LICENSE để biết thêm chi tiết.
