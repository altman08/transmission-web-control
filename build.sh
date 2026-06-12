#!/bin/bash
# ========== 配置区域，按需修改 ==========
SRC_DIR="$(cd "$(dirname "$0")/src" && pwd)"
OUTPUT_DIR="$(cd "$(dirname "$0")" && pwd)/dist"
PACK_NAME="transmission-web-control.tar.gz"
# ========================================

echo "=== 开始打包 ==="
echo "源目录: $SRC_DIR"
echo "输出目录: $OUTPUT_DIR"
rm -rf $OUTPUT_DIR

# 压缩 JS 源文件到 min 目录
echo ""
echo "=== 压缩 JS 文件 ==="
cd "$SRC_DIR/tr-web-control/script"
uglifyjs transmission.js     -o min/transmission.min.js     -c -m && echo "✓ transmission.min.js"
uglifyjs transmission.torrents.js -o min/transmission.torrents.min.js -c -m && echo "✓ transmission.torrents.min.js"
uglifyjs system.js           -o min/system.min.js           -c -m && echo "✓ system.min.js"

# 清理输出目录
echo ""
echo "=== 准备输出目录 ==="
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# 复制所有文件，然后删除不需要的
echo "复制文件..."
cp -r "$SRC_DIR/." "$OUTPUT_DIR/"

# 删除源 JS 文件（浏览器只加载 min/ 目录下的）
echo ""
echo "=== 剔除冗余文件 ==="
rm -f "$OUTPUT_DIR/tr-web-control/script/system.js"                && echo "✓ 删除 script/system.js"
rm -f "$OUTPUT_DIR/tr-web-control/script/transmission.js"          && echo "✓ 删除 script/transmission.js"
rm -f "$OUTPUT_DIR/tr-web-control/script/transmission.torrents.js" && echo "✓ 删除 script/transmission.torrents.js"
rm -f "$OUTPUT_DIR/tr-web-control/script/FileSaver.js"             && echo "✓ 删除 script/FileSaver.js"
rm -f "$OUTPUT_DIR/tr-web-control/script/public.js"                && echo "✓ 删除 script/public.js"
rm -f "$OUTPUT_DIR/tr-web-control/script/system.mobile.js"         && echo "✓ 删除 script/system.mobile.js"

# 删除示例/文档文件
rm -f "$OUTPUT_DIR/tr-web-control/style/iconfont/example.html"     && echo "✓ 删除 iconfont/example.html"

# 打包
echo ""
echo "=== 打包 ==="
cd "$OUTPUT_DIR/.."
tar -czf "$PACK_NAME" -C "$OUTPUT_DIR" .
echo "✓ 打包完成: $(pwd)/$PACK_NAME"

echo ""
echo "=== 完成 ==="
rm -rf $OUTPUT_DIR