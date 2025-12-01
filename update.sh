#!/bin/bash

# ================= 再次确认路径 =================
# 你之前的日志显示源文件在这里，请确认这里面的 PDF 是不是完整的？
SOURCE_DIR="/d/Latexfile/Projects/build"

# 目标路径
TARGET_DIR="./notes"
# ===============================================

echo "==== 🚀 强力同步模式 ===="
echo "源目录: $SOURCE_DIR"

# 1. 检查源目录
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ 错误：找不到源目录！"
    read -p "按回车退出..."
    exit 1
fi

# 2. 【关键步骤】先删除旧文件，打断硬链接
echo "🗑️  正在清理旧的 PDF (打断硬链接)..."
# 只删除 pdf，不删 html
rm -f "$TARGET_DIR"/*.pdf

# 3. 重新复制
echo "📋 正在从源目录复制全新的 PDF..."
cp -v "$SOURCE_DIR"/*.pdf "$TARGET_DIR"

# 4. 提交到 GitHub
echo "📦 提交更改到 GitHub..."
git add .
git commit -m "Force update: Fresh copy of PDF notes"
git push

echo "🎉 成功！硬链接已断开，新笔记已上传。"
read -p "按回车键退出..."
