# 🚀 Hướng dẫn Cài đặt Flutter trên Windows - Chi tiết từng bước

## 📋 Yêu cầu hệ thống

- Windows 10 hoặc mới hơn (64-bit)
- Ít nhất 2.5 GB dung lượng trống
- Git for Windows (sẽ hướng dẫn cài đặt)
- Windows PowerShell 5.0 hoặc mới hơn

---

## Bước 1️⃣: Cài đặt Git (nếu chưa có)

### Kiểm tra Git đã cài chưa:

Mở PowerShell và chạy:

```powershell
git --version
```

### Nếu chưa có Git:

1. Truy cập: https://git-scm.com/download/win
2. Tải file installer (64-bit Git for Windows Setup)
3. Chạy file installer và chọn **Next** cho tất cả cài đặt mặc định
4. Sau khi cài xong, **khởi động lại PowerShell**

---

## Bước 2️⃣: Tải Flutter SDK

### Option 1: Tải trực tiếp (Khuyên dùng)

1. **Tải Flutter SDK**:
   - Truy cập: https://docs.flutter.dev/get-started/install/windows
   - Click vào nút **"Download Flutter SDK"**
   - Hoặc link trực tiếp: https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip
2. **Giải nén file**:

   - Giải nén file `flutter_windows_xxx-stable.zip` vào thư mục \*\*C:\*\*
   - Kết quả: Bạn sẽ có thư mục `C:\flutter`

   ⚠️ **LƯU Ý**:

   - KHÔNG giải nén vào thư mục yêu cầu quyền admin (như `C:\Program Files`)
   - Đường dẫn KHÔNG được có khoảng trắng hoặc ký tự đặc biệt

### Option 2: Sử dụng Git Clone (Cho người có kinh nghiệm)

```powershell
cd C:\
git clone https://github.com/flutter/flutter.git -b stable
```

---

## Bước 3️⃣: Thêm Flutter vào PATH

### Cách 1: Sử dụng GUI (Dễ hơn)

1. **Mở Environment Variables**:

   - Nhấn `Windows + R`
   - Gõ: `sysdm.cpl` và nhấn Enter
   - Chọn tab **"Advanced"**
   - Click **"Environment Variables"**

2. **Chỉnh sửa PATH**:

   - Trong phần **"User variables"**, tìm biến `Path`
   - Click **"Edit"**
   - Click **"New"**
   - Thêm dòng: `C:\flutter\bin`
   - Click **"OK"** → **"OK"** → **"OK"**

3. **Khởi động lại PowerShell**

### Cách 2: Sử dụng PowerShell (Nhanh hơn)

```powershell
# Chạy PowerShell AS ADMINISTRATOR
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\flutter\bin", "User")
```

Sau đó **khởi động lại PowerShell**.

---

## Bước 4️⃣: Kiểm tra cài đặt

Mở PowerShell MỚI và chạy:

```powershell
flutter --version
```

Bạn sẽ thấy thông tin Flutter version. Tiếp tục chạy:

```powershell
flutter doctor
```

### Hiểu kết quả `flutter doctor`:

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x)
[✗] Android toolchain - develop for Android devices
    ✗ Unable to locate Android SDK.
[✗] Chrome - develop for the web (Not installed)
[✓] Windows Version (Windows 10 or later)
[!] Android Studio (not installed)
[✓] VS Code (version 1.x.x)
[!] Connected device
    ! No devices available
```

**Giải thích các dấu**:

- ✓ (Tick xanh) = OK, không cần làm gì
- ✗ (X đỏ) = Thiếu, nhưng có thể bỏ qua nếu không cần
- ! (Dấu chấm than) = Cảnh báo, có thể bỏ qua

**Lưu ý quan trọng**:

- Nếu bạn chỉ muốn chạy trên **Web/Chrome**, CHỈ CẦN cài Chrome
- Nếu muốn chạy trên **Android**, cần cài Android Studio
- Nếu muốn chạy trên **iOS**, cần máy Mac với Xcode

---

## Bước 5️⃣: Cài đặt Chrome (Để chạy Flutter Web)

### Nếu chưa có Chrome:

1. Tải Chrome: https://www.google.com/chrome/
2. Cài đặt bình thường
3. Chạy lại: `flutter doctor`

### Kích hoạt Flutter Web:

```powershell
flutter config --enable-web
```

---

## Bước 6️⃣: (Tùy chọn) Cài đặt Android Studio

### Chỉ cần nếu bạn muốn build app Android:

1. **Tải Android Studio**:

   - Truy cập: https://developer.android.com/studio
   - Tải và cài đặt

2. **Cài Flutter & Dart plugins**:

   - Mở Android Studio
   - File → Settings → Plugins
   - Tìm "Flutter" và cài đặt
   - Tìm "Dart" và cài đặt
   - Khởi động lại Android Studio

3. **Cài Android SDK**:

   - Mở Android Studio
   - Tools → SDK Manager
   - Chọn latest Android SDK
   - Click "Apply"

4. **Chấp nhận licenses**:
   ```powershell
   flutter doctor --android-licenses
   ```
   Gõ `y` cho tất cả các câu hỏi.

---

## Bước 7️⃣: Chạy ứng dụng Flutter đầu tiên! 🎉

### Trên Chrome/Web:

```powershell
cd c:\Users\VietLong\Downloads\Github\Pihome_FMS\flutter_taisan
flutter pub get
flutter run -d chrome
```

### Trên Android Emulator:

1. **Tạo emulator** (nếu chưa có):

   ```powershell
   flutter emulators --create
   ```

2. **Chạy emulator**:

   ```powershell
   flutter emulators --launch <emulator_id>
   ```

3. **Chạy app**:
   ```powershell
   flutter run
   ```

---

## 🔧 Sửa lỗi thường gặp

### Lỗi: "flutter is not recognized"

**Nguyên nhân**: Flutter chưa được thêm vào PATH

**Giải pháp**:

1. Kiểm tra lại Bước 3
2. Khởi động lại PowerShell
3. Thử chạy với đường dẫn đầy đủ:
   ```powershell
   C:\flutter\bin\flutter doctor
   ```

### Lỗi: "Unable to locate Android SDK"

**Giải pháp**:

- Nếu KHÔNG cần build Android app → BỎ QUA
- Nếu cần → Làm theo Bước 6

### Lỗi: "cmdline-tools component is missing"

**Giải pháp**:

```powershell
flutter doctor --android-licenses
```

### Lỗi: Git not found

**Giải pháp**: Cài Git theo Bước 1

---

## ✅ Checklist Hoàn thành

- [ ] Đã cài Git
- [ ] Đã tải và giải nén Flutter SDK vào C:\flutter
- [ ] Đã thêm C:\flutter\bin vào PATH
- [ ] Chạy `flutter doctor` thành công
- [ ] Đã cài Chrome (cho Web)
- [ ] (Tùy chọn) Đã cài Android Studio (cho Android)
- [ ] Chạy `flutter run -d chrome` thành công

---

## 🎓 Lệnh Flutter cơ bản

```powershell
# Kiểm tra version
flutter --version

# Kiểm tra hệ thống
flutter doctor

# Xem danh sách thiết bị
flutter devices

# Lấy dependencies
flutter pub get

# Chạy app
flutter run

# Chạy trên Chrome
flutter run -d chrome

# Chạy với hot reload
flutter run --hot

# Build APK (Android)
flutter build apk

# Build Web
flutter build web

# Xóa cache (nếu có lỗi)
flutter clean
```

---

## 📚 Tài liệu tham khảo

- **Flutter Official**: https://flutter.dev
- **Flutter Docs**: https://docs.flutter.dev
- **Flutter YouTube**: https://www.youtube.com/flutterdev
- **Flutter Community**: https://flutter.dev/community

---

## 🆘 Cần thêm trợ giúp?

Nếu gặp lỗi, hãy:

1. Copy toàn bộ error message
2. Chạy: `flutter doctor -v` và copy kết quả
3. Hỏi tôi để được hỗ trợ!

---

**Chúc bạn cài đặt thành công! 🎉**
