#!/bin/bash

# ================= 配置区域 =================

# 1. 你的 LaTeX 源文件在哪里？
# 注意：在 Git Bash 里，D盘要写成 /d/，反斜杠 \ 要变成斜杠 /
# 请把下面这行修改为你存放 .tex 和编译副产品的那个文件夹路径
SOURCE_DIR="/d/Latexfile/Projects/build"  

# 2. 你的网站笔记文件夹在哪里？
# (如果你把脚本放在网站根目录，这就不用改)
TARGET_DIR="./notes"

# ===========================================

echo "🚀 开始更新..."

# 检查源目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
  echo "❌ 错误：找不到源文件夹，请检查 SOURCE_DIR 路径是否正确！"
  read -p "按回车键退出..."
  exit 1
fi

echo "📂 正在从源目录抓取 PDF 文件..."
echo "   源目录: $SOURCE_DIR"
echo "   只提取: *.pdf"

# 核心命令：只复制 PDF。
# > /dev/null 2>&1 是为了不显示太杂乱的信息，只让你看到结果
cp -f "$SOURCE_DIR"/*.pdf "$TARGET_DIR"

echo "✅ 复制完成！现在的 notes 文件夹里只有 PDF。"

echo "📦 正在提交到 GitHub..."
git add .
git commit -m "Auto update: Sync latest PDFs from local build"
git push

echo "🎉 搞定！你的网站已更新。"
echo "------------------------------------------------"
read -p "按回车键退出..."
