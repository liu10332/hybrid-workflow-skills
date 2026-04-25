#!/bin/bash

# Hybrid Workflow Skills 验证脚本
# 用于验证技能文件的完整性和格式

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

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# 验证计数
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0

# 检查函数
check() {
    local description="$1"
    local condition="$2"
    
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    
    if eval "$condition"; then
        print_success "$description"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        print_error "$description"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
}

# 验证目录结构
validate_directory_structure() {
    print_info "验证目录结构..."
    
    # 检查主目录
    check "项目根目录存在" "[ -d '$PROJECT_DIR' ]"
    check "skills目录存在" "[ -d '$PROJECT_DIR/skills' ]"
    check "docs目录存在" "[ -d '$PROJECT_DIR/docs' ]"
    check "examples目录存在" "[ -d '$PROJECT_DIR/examples' ]"
    check "scripts目录存在" "[ -d '$PROJECT_DIR/scripts' ]"
    check ".github目录存在" "[ -d '$PROJECT_DIR/.github' ]"
}

# 验证核心文件
validate_core_files() {
    print_info "验证核心文件..."
    
    check "README.md存在" "[ -f '$PROJECT_DIR/README.md' ]"
    check "LICENSE存在" "[ -f '$PROJECT_DIR/LICENSE' ]"
    check ".gitignore存在" "[ -f '$PROJECT_DIR/.gitignore' ]"
    check "CONTRIBUTING.md存在" "[ -f '$PROJECT_DIR/CONTRIBUTING.md' ]"
    check "CHANGELOG.md存在" "[ -f '$PROJECT_DIR/CHANGELOG.md' ]"
}

# 验证技能文件
validate_skills() {
    print_info "验证技能文件..."
    
    local skills=(
        "hybrid-workflow"
        "hybrid-project-init"
        "brainstorming"
        "discuss-phase"
        "writing-plans"
        "subagent-driven-development"
        "test-driven-development"
        "requesting-code-review"
        "task-workspace"
        "efficient-progress-tracking"
    )
    
    for skill in "${skills[@]}"; do
        check "技能 $skill 目录存在" "[ -d '$PROJECT_DIR/skills/$skill' ]"
        check "技能 $skill 的SKILL.md存在" "[ -f '$PROJECT_DIR/skills/$skill/SKILL.md' ]"
    done
}

# 验证文档文件
validate_documentation() {
    print_info "验证文档文件..."
    
    check "getting-started.md存在" "[ -f '$PROJECT_DIR/docs/getting-started.md' ]"
    check "concepts.md存在" "[ -f '$PROJECT_DIR/docs/concepts.md' ]"
    check "skills文档目录存在" "[ -d '$PROJECT_DIR/docs/skills' ]"
    check "examples文档目录存在" "[ -d '$PROJECT_DIR/docs/examples' ]"
}

# 验证脚本文件
validate_scripts() {
    print_info "验证脚本文件..."
    
    check "install.sh存在" "[ -f '$PROJECT_DIR/scripts/install.sh' ]"
    check "install.sh可执行" "[ -x '$PROJECT_DIR/scripts/install.sh' ]"
}

# 验证GitHub模板
validate_github_templates() {
    print_info "验证GitHub模板..."
    
    check "Issue模板目录存在" "[ -d '$PROJECT_DIR/.github/ISSUE_TEMPLATE' ]"
    check "PR模板存在" "[ -f '$PROJECT_DIR/.github/PULL_REQUEST_TEMPLATE.md' ]"
    check "bug_report.md存在" "[ -f '$PROJECT_DIR/.github/ISSUE_TEMPLATE/bug_report.md' ]"
    check "feature_request.md存在" "[ -f '$PROJECT_DIR/.github/ISSUE_TEMPLATE/feature_request.md' ]"
}

# 显示验证结果
show_results() {
    echo ""
    echo "=========================================="
    echo "  验证结果"
    echo "=========================================="
    echo ""
    echo "总检查数: $TOTAL_CHECKS"
    echo "通过: $PASSED_CHECKS"
    echo "失败: $FAILED_CHECKS"
    echo ""
    
    if [ $FAILED_CHECKS -eq 0 ]; then
        print_success "所有检查通过！项目结构完整。"
    else
        print_warning "有 $FAILED_CHECKS 项检查未通过。"
        echo ""
        echo "请检查以下问题："
        echo "1. 确保所有必要的文件和目录都存在"
        echo "2. 检查文件权限"
        echo "3. 查看错误信息了解详情"
    fi
    
    echo ""
}

# 主函数
main() {
    print_info "开始验证 Hybrid Workflow Skills..."
    echo ""
    
    # 运行所有验证
    validate_directory_structure
    echo ""
    validate_core_files
    echo ""
    validate_skills
    echo ""
    validate_documentation
    echo ""
    validate_scripts
    echo ""
    validate_github_templates
    
    # 显示结果
    show_results
    
    # 返回状态码
    if [ $FAILED_CHECKS -eq 0 ]; then
        exit 0
    else
        exit 1
    fi
}

# 运行主函数
main "$@"