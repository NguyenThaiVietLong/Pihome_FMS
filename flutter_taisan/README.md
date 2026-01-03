# Flutter Tài Sản (Asset Management App)

Ứng dụng quản lý tài sản được chuyển đổi từ HTML sang Flutter.

## Tính năng

- ✅ Màn hình danh sách tài sản
- ✅ Thanh điều hướng trên cùng với tabs
- ✅ Thanh tìm kiếm và bộ lọc
- ✅ Thẻ tài sản với thông tin chi tiết
- ✅ Thanh điều hướng dưới cùng với nút trung tâm nổi bật
- ✅ Thiết kế responsive và hiện đại

## Cấu trúc thư mục

```
lib/
├── main.dart                          # Entry point
├── models/
│   └── asset.dart                     # Model dữ liệu tài sản
├── screens/
│   └── asset_list_screen.dart         # Màn hình chính
└── widgets/
    ├── custom_app_bar.dart            # Thanh điều hướng trên
    ├── search_filter_section.dart     # Phần tìm kiếm và lọc
    ├── asset_card.dart                # Thẻ tài sản
    └── bottom_nav_bar.dart            # Thanh điều hướng dưới
```

## Cài đặt và chạy

1. **Cài đặt Flutter** (nếu chưa có):

   - Truy cập: https://flutter.dev/docs/get-started/install
   - Làm theo hướng dẫn cho hệ điều hành của bạn

2. **Kiểm tra cài đặt**:

   ```bash
   flutter doctor
   ```

3. **Lấy dependencies**:

   ```bash
   cd flutter_taisan
   flutter pub get
   ```

4. **Chạy ứng dụng**:

   ```bash
   # Trên emulator/simulator
   flutter run

   # Hoặc chạy trên Chrome (web)
   flutter run -d chrome
   ```

## Màu sắc chính

- **Primary (Deep Blue)**: `#1E3A8A`
- **Secondary (Amber)**: `#F59E0B`
- **Background**: `#F3F4F6`
- **Status Green**: `#D1FAE5` / `#047857`
- **Status Orange**: `#FEF3C7` / `#D97706`

## Build cho production

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## Tùy chỉnh

Bạn có thể tùy chỉnh:

- Màu sắc trong `lib/main.dart`
- Dữ liệu mẫu trong `lib/screens/asset_list_screen.dart`
- Các widget riêng lẻ trong thư mục `lib/widgets/`

## Yêu cầu

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.0.0
