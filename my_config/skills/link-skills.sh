#!/bin/bash
# 将 ~/.config/nvim/my_config/skills/ 下每个 skill 目录软链接到 ~/.agents/skills/
# 目录结构：skills/<skill-name>/SKILL.md → ~/.agents/skills/<skill-name>/SKILL.md
# 用于让 Deep Code CLI 加载自定义 skill

SRC_DIR="/home/xuan/.config/nvim/my_config/skills"
TARGET_DIR="$HOME/.agents/skills"

# 确保目标目录存在
mkdir -p "$TARGET_DIR"

linked=0
removed=0

for skill_dir in "$SRC_DIR"/*/; do
    [ -d "$skill_dir" ] || continue

    skill_name=$(basename "$skill_dir")

    # 跳过 scripts、templates 等非 skill 子目录（没有 SKILL.md 的不处理）
    [ -f "$skill_dir/SKILL.md" ] || continue

    link_path="$TARGET_DIR/$skill_name"

    # 删除已存在的旧链接或目录
    if [ -L "$link_path" ] || [ -e "$link_path" ]; then
        rm -rf "$link_path"
        ((removed++))
    fi

    # 创建整个目录的软链接
    ln -s "$skill_dir" "$link_path"
    echo "  + $link_path -> $skill_dir"
    ((linked++))
done

echo "---"
echo "已删除 $removed 个旧链接/目录，已创建 $linked 个新链接。"
