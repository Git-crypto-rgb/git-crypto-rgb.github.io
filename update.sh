#!/bin/bash

# ================= 关键修改位置 =================
# 修正后的精确路径
SOURCE_DIR="/d/Latexfile/Projects/build"

# 目标路径 (你的网站 notes 文件夹)
TARGET_DIR="./notes"
# ===============================================

echo "==== 🚀 开始同步笔记 ===="
echo "源目录: $SOURCE_DIR"

# 1. 双重检查目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ 错误：找不到源目录！"
    echo "   请确认你的笔记是在 D 盘吗？如果是在 C 盘，请把脚本里的 /d/ 改成 /c/"
    read -p "按回车退出..."
    exit 1
fi

# 2. 检查是否有 PDF
count=$(ls "$SOURCE_DIR"/*.pdf 2>/dev/null | wc -l)
if [ "$count" -eq 0 ]; then
    echo "⚠️  警告：在这个文件夹里没找到 PDF 文件。"
    echo "    请检查你是否已经编译了 LaTeX？或者文件名是不是大写的 .PDF？"
    read -p "按回车退出..."
    exit 1
else
    echo "✅ 发现 $count 个 PDF 文件，准备更新..."
fi

# 3. 强制复制 (覆盖旧文件)
cp -f -v "$SOURCE_DIR"/*.pdf "$TARGET_DIR"

# 4. 提交到 GitHub
echo "📦 提交更改到 GitHub..."
git add .
git commit -m "Auto update: Sync notes from Projects/shared"
git push

echo "🎉 成功！所有笔记已同步到网站。"
read -p "按回车键退出..."
