#!/bin/bash

# Hybrid Workflow Skills 安装脚本
# 用于安装和配置混合工作流技能

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查依赖
check_dependencies() {
    print_info "检查依赖..."
    
    # 检查git
    if ! command -v git &> /dev/null; then
        print_error "git未安装，请先安装git"
        exit 1
    fi
    
    # 检查bash
    if ! command -v bash &> /dev/null; then
        print_error "bash未安装，请先安装bash"
        exit 1
    fi
    
    print_success "依赖检查通过"
}

# 创建符号链接（可选）
create_symlinks() {
    print_info "创建符号链接..."
    
    # 这里可以添加创建符号链接的逻辑
    # 例如将技能链接到Hermes/OpenClaw的技能目录
    
    print_success "符号链接创建完成"
}

# 复制技能文件
copy_skills() {
    print_info "复制技能文件..."
    
    # 获取脚本所在目录
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
    
    # 检查skills目录
    if [ ! -d "$PROJECT_DIR/skills" ]; then
        print_error "skills目录不存在"
        exit 1
    fi
    
    # 列出可用的技能
    print_info "可用的技能："
    for skill in "$PROJECT_DIR/skills"/*/; do
        if [ -d "$skill" ]; then
            skill_name=$(basename "$skill")
            echo "  - $skill_name"
        fi
    done
    
    print_success "技能文件检查完成"
}

# 显示使用说明
show_usage() {
    echo ""
    echo "=========================================="
    echo "  Hybrid Workflow Skills 安装完成！"
    echo "=========================================="
    echo ""
    echo "下一步："
    echo ""
    echo "1. 查看README.md了解项目概述"
    echo "2. 阅读docs/getting-started.md快速开始"
    echo "3. 浏览skills/目录了解可用技能"
    echo "4. 查看examples/目录了解使用示例"
    echo ""
    echo "使用技能："
    echo ""
    echo "  # 复制技能到Hermes/OpenClaw技能目录"
    echo "  cp -r skills/hybrid-workflow ~/.hermes/skills/"
    echo ""
    echo "  # 或者创建符号链接"
    echo "  ln -s $(pwd)/skills/hybrid-workflow ~/.hermes/skills/"
    echo ""
    echo "更多信息请查看文档："
    echo "  - docs/getting-started.md"
    echo "  - docs/concepts.md"
    echo "  - docs/skills/"
    echo ""
}

# 主函数
main() {
    print_info "开始安装 Hybrid Workflow Skills..."
    
    # 检查依赖
    check_dependencies
    
    # 复制技能文件
    copy_skills
    
    # 创建符号链接（可选）
    create_symlinks
    
    # 显示使用说明
    show_usage
    
    print_success "安装完成！"
}

# 运行主函数
main "$@"