# 🎨 Difficulty Badge System - Hướng dẫn sử dụng

## 📋 Tổng quan

Hệ thống Difficulty Badge cung cấp một cách hiển thị độ khó của bài thi một cách trực quan, hiện đại với:
- ✨ Gradient backgrounds đẹp mắt
- 🎭 Hover animations mượt mà
- 📱 Responsive design
- ♿ Accessibility support
- 🎯 Multiple size variants

---

## 🚀 Cài đặt nhanh

### 1. Include CSS file

```html
<link rel="stylesheet" href="css/difficulty-badge.css">
```

### 2. Sử dụng trong JSP

```jsp
<%
    int diffLevel = exam.getDifficultyLevel();
    String diffBadgeClass = "";
    String diffIcon = "";
    String diffText = "";
    
    if (diffLevel == 1) {
        diffBadgeClass = "difficulty-badge difficulty-easy";
        diffIcon = "🟢";
        diffText = "Dễ";
    } else if (diffLevel == 2) {
        diffBadgeClass = "difficulty-badge difficulty-medium";
        diffIcon = "🟡";
        diffText = "Vừa";
    } else if (diffLevel == 3) {
        diffBadgeClass = "difficulty-badge difficulty-hard";
        diffIcon = "🔴";
        diffText = "Khó";
    }
%>

<span class="<%= diffBadgeClass %>">
    <span class="icon"><%= diffIcon %></span>
    <%= diffText %>
</span>
```

### 3. Kích hoạt Tooltips (Optional)

```html
<span class="difficulty-badge difficulty-easy" 
      data-bs-toggle="tooltip" 
      title="Phù hợp cho người mới bắt đầu">
    <span class="icon">🟢</span>
    Dễ
</span>
```

```javascript
<script>
document.addEventListener('DOMContentLoaded', function() {
    var tooltipTriggerList = [].slice.call(
        document.querySelectorAll('[data-bs-toggle="tooltip"]')
    );
    tooltipTriggerList.map(function (el) {
        return new bootstrap.Tooltip(el);
    });
});
</script>
```

---

## 🎨 Các loại Badge

### Difficulty Levels

| Level | Class | Icon | Text | Màu sắc |
|-------|-------|------|------|---------|
| 1 | `difficulty-easy` | 🟢 | Dễ | Green gradient |
| 2 | `difficulty-medium` | 🟡 | Vừa | Orange/Yellow gradient |
| 3 | `difficulty-hard` | 🔴 | Khó | Red gradient |
| N/A | `difficulty-unknown` | ⚪ | N/A | Gray gradient |

### Size Variants

```html
<!-- Small - cho bảng/compact views -->
<span class="difficulty-badge difficulty-badge-sm difficulty-easy">
    <span class="icon">🟢</span> Dễ
</span>

<!-- Default - size chuẩn -->
<span class="difficulty-badge difficulty-easy">
    <span class="icon">🟢</span> Dễ
</span>

<!-- Large - cho headers/highlights -->
<span class="difficulty-badge difficulty-badge-lg difficulty-easy">
    <span class="icon">🟢</span> Dễ
</span>
```

---

## 📍 Use Cases

### 1. Trong Cards (examlist.jsp)

```jsp
<div class="badges-container justify-content-center">
    <span class="price-badge">Miễn phí</span>
    <span class="difficulty-badge difficulty-easy">
        <span class="icon">🟢</span>
        Dễ
    </span>
</div>
```

### 2. Trong Tables

```html
<table class="table">
    <thead>
        <tr>
            <th>Tên bài</th>
            <th>Độ khó</th>
            <th>Giá</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Toán cơ bản</td>
            <td class="text-center">
                <span class="difficulty-badge difficulty-badge-sm difficulty-easy">
                    <span class="icon">🟢</span>
                    Dễ
                </span>
            </td>
            <td>Miễn phí</td>
        </tr>
    </tbody>
</table>
```

### 3. Trong Modal

```html
<div class="modal-body">
    <ul class="list-unstyled">
        <li>
            <strong>Độ khó:</strong>
            <span class="difficulty-badge difficulty-medium">
                <span class="icon">🟡</span>
                Vừa
            </span>
        </li>
    </ul>
</div>
```

---

## 🎭 Animation & Effects

### Default Animations
- ✅ Hover lift effect (translateY)
- ✅ Shadow expansion on hover
- ✅ Pulsing icon animation
- ✅ Smooth color transitions
- ✅ Appear animation on load

### Disable Animation (if needed)

```css
.difficulty-badge {
    animation: none !important;
}

.difficulty-badge .icon {
    animation: none !important;
}
```

---

## 📱 Responsive Behavior

Badges tự động điều chỉnh size trên mobile:

```css
@media (max-width: 576px) {
    .difficulty-badge {
        font-size: 0.75rem;
        padding: 5px 10px;
    }
}
```

---

## ♿ Accessibility Features

1. **High Contrast Mode Support**
   - Border tự động tăng độ dày
   - Font weight tăng lên

2. **Tooltip for Context**
   - Thêm thông tin chi tiết
   - Screen reader friendly

3. **Print Styles**
   - Tự động chuyển về dạng bordered
   - Loại bỏ shadow và gradient

---

## 🎯 Best Practices

### ✅ DO
- Sử dụng `difficulty-badge-sm` trong bảng
- Thêm tooltip cho thông tin bổ sung
- Dùng `badges-container` để nhóm nhiều badges
- Test trên mobile devices

### ❌ DON'T
- Không mix nhiều size trong cùng 1 context
- Không override màu gradient (giữ consistency)
- Không dùng badge quá lớn trong compact space
- Không quên kích hoạt tooltips nếu sử dụng

---

## 🔧 Customization

### Thay đổi màu sắc

```css
/* Custom Easy color */
.difficulty-easy {
    background: linear-gradient(135deg, #your-color1, #your-color2);
    border-color: #your-color1;
}
```

### Thay đổi animation speed

```css
.difficulty-badge {
    transition: all 0.5s ease; /* Thay vì 0.3s */
}
```

### Thêm new level

```css
.difficulty-expert {
    background: linear-gradient(135deg, #8e44ad 0%, #9b59b6 100%);
    color: white !important;
    border-color: #8e44ad;
}
```

---

## 📂 File Structure

```
web/
├── css/
│   └── difficulty-badge.css       # Main CSS file
├── examlist.jsp                   # Example implementation
└── difficulty-badge-demo.html     # Live demo page
```

---

## 🐛 Troubleshooting

### Tooltips không hoạt động
- ✅ Đảm bảo đã include Bootstrap 5
- ✅ Kiểm tra JavaScript đã được thêm
- ✅ Verify Bootstrap bundle (không chỉ CSS)

### Animations không mượt
- ✅ Kiểm tra browser support
- ✅ Test performance với nhiều badges
- ✅ Consider disabling animations trên low-end devices

### Responsive issues
- ✅ Test trên nhiều screen sizes
- ✅ Verify viewport meta tag
- ✅ Check container overflow

---

## 📊 Browser Support

| Browser | Version | Support |
|---------|---------|---------|
| Chrome | 90+ | ✅ Full |
| Firefox | 88+ | ✅ Full |
| Safari | 14+ | ✅ Full |
| Edge | 90+ | ✅ Full |
| IE11 | - | ⚠️ Partial (no gradients) |

---

## 🎓 Examples

Xem live demo tại: `web/difficulty-badge-demo.html`

Hoặc truy cập: `http://localhost:8080/THI247/difficulty-badge-demo.html`

---

## 📝 Version History

### v1.0.0 (Current)
- ✅ Initial release
- ✅ 4 difficulty levels
- ✅ 3 size variants
- ✅ Responsive design
- ✅ Tooltip support
- ✅ Accessibility features

---

## 👨‍💻 Maintainer

Nếu có vấn đề hoặc đề xuất cải tiến, vui lòng liên hệ team development.

---

## 📄 License

Internal use only - THI247 Project

---

**Happy Coding! 🚀**

