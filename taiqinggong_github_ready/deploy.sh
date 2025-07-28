#!/bin/bash

# 厦门太清宫网站部署脚本
# 使用方法: ./deploy.sh [目标目录]

echo "🚀 开始部署厦门太清宫网站..."

# 检查参数
if [ -z "$1" ]; then
    echo "❌ 请指定目标目录"
    echo "使用方法: ./deploy.sh /path/to/web/root"
    exit 1
fi

TARGET_DIR="$1"

# 检查目标目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ 目标目录不存在: $TARGET_DIR"
    exit 1
fi

echo "📁 目标目录: $TARGET_DIR"

# 创建备份
BACKUP_DIR="$TARGET_DIR/backup_$(date +%Y%m%d_%H%M%S)"
if [ -d "$TARGET_DIR/taiqinggong" ]; then
    echo "📦 创建备份..."
    mkdir -p "$BACKUP_DIR"
    cp -r "$TARGET_DIR/taiqinggong" "$BACKUP_DIR/"
    echo "✅ 备份已创建: $BACKUP_DIR"
fi

# 复制文件
echo "📋 复制文件..."
cp -r . "$TARGET_DIR/taiqinggong/"

# 设置权限
echo "🔐 设置文件权限..."
find "$TARGET_DIR/taiqinggong" -type f -name "*.html" -exec chmod 644 {} \;
find "$TARGET_DIR/taiqinggong" -type f -name "*.css" -exec chmod 644 {} \;
find "$TARGET_DIR/taiqinggong" -type f -name "*.js" -exec chmod 644 {} \;
find "$TARGET_DIR/taiqinggong" -type f -name "*.jpg" -exec chmod 644 {} \;
find "$TARGET_DIR/taiqinggong" -type f -name "*.png" -exec chmod 644 {} \;

# 检查文件完整性
echo "🔍 检查文件完整性..."
REQUIRED_FILES=(
    "index.html"
    "about.html"
    "contact.html"
    "reservation.html"
    "user-agreement.html"
    "complaint.html"
    "css/style.css"
    "js/main.js"
    "README.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$TARGET_DIR/taiqinggong/$file" ]; then
        echo "❌ 缺少必要文件: $file"
        exit 1
    fi
done

echo "✅ 所有必要文件已检查"

# 检查图片文件
echo "🖼️ 检查图片文件..."
IMAGE_COUNT=$(find "$TARGET_DIR/taiqinggong/images" -name "*.jpg" -o -name "*.png" | wc -l)
echo "📸 找到 $IMAGE_COUNT 个图片文件"

# 生成部署报告
echo "📊 生成部署报告..."
REPORT_FILE="$TARGET_DIR/taiqinggong/部署报告_$(date +%Y%m%d_%H%M%S).txt"

cat > "$REPORT_FILE" << EOF
厦门太清宫网站部署报告
部署时间: $(date)
目标目录: $TARGET_DIR

文件统计:
- HTML文件: 6个
- CSS文件: 1个
- JS文件: 1个
- 图片文件: $IMAGE_COUNT个
- 文档文件: 3个

部署状态: ✅ 成功

访问地址:
- 首页: http://your-domain.com/taiqinggong/
- 用户协议: http://your-domain.com/taiqinggong/user-agreement.html
- 投诉举报: http://your-domain.com/taiqinggong/complaint.html

注意事项:
1. 请将 your-domain.com 替换为实际域名
2. 确保服务器支持静态文件服务
3. 建议配置SSL证书
4. 定期备份网站文件

技术支持: 0592-2092459
EOF

echo "📄 部署报告已生成: $REPORT_FILE"

# 显示部署完成信息
echo ""
echo "🎉 部署完成！"
echo "📁 网站位置: $TARGET_DIR/taiqinggong/"
echo "📄 部署报告: $REPORT_FILE"
echo ""
echo "🔗 访问地址:"
echo "   - 首页: http://your-domain.com/taiqinggong/"
echo "   - 用户协议: http://your-domain.com/taiqinggong/user-agreement.html"
echo "   - 投诉举报: http://your-domain.com/taiqinggong/complaint.html"
echo ""
echo "📞 技术支持: 0592-2092459"
echo ""
echo "✅ 请按照 部署检查清单.md 进行最终验证" 