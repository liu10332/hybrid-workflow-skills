#!/bin/bash

# Simple Web App 运行脚本
# 用于启动本地服务器查看示例项目

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

# 检查Python是否可用
check_python() {
    if command -v python3 &> /dev/null; then
        PYTHON="python3"
    elif command -v python &> /dev/null; then
        PYTHON="python"
    else
        return 1
    fi
    return 0
}

# 检查Node.js是否可用
check_node() {
    if command -v node &> /dev/null; then
        return 0
    fi
    return 1
}

# 启动Python服务器
start_python_server() {
    print_info "使用Python启动服务器..."
    print_success "服务器启动成功！"
    echo ""
    echo "访问地址: http://localhost:8000"
    echo "按 Ctrl+C 停止服务器"
    echo ""
    
    cd "$SCRIPT_DIR"
    $PYTHON -m http.server 8000
}

# 启动Node.js服务器
start_node_server() {
    print_info "使用Node.js启动服务器..."
    
    # 检查是否安装了serve
    if ! command -v npx &> /dev/null; then
        print_error "npx未安装，请先安装Node.js"
        exit 1
    fi
    
    print_success "服务器启动成功！"
    echo ""
    echo "访问地址: http://localhost:3000"
    echo "按 Ctrl+C 停止服务器"
    echo ""
    
    cd "$SCRIPT_DIR"
    npx serve .
}

# 显示使用说明
show_usage() {
    echo "Simple Web App 运行脚本"
    echo ""
    echo "使用方法:"
    echo "  ./run.sh [选项]"
    echo ""
    echo "选项:"
    echo "  -p, --python    使用Python服务器 (默认)"
    echo "  -n, --node      使用Node.js服务器"
    echo "  -h, --help      显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  ./run.sh          # 使用Python服务器"
    echo "  ./run.sh --node   # 使用Node.js服务器"
    echo ""
}

# 主函数
main() {
    local server_type="python"
    
    # 解析命令行参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -p|--python)
                server_type="python"
                shift
                ;;
            -n|--node)
                server_type="node"
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                print_error "未知选项: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    print_info "启动 Simple Web App..."
    echo ""
    
    # 根据选择启动服务器
    case $server_type in
        python)
            if check_python; then
                start_python_server
            else
                print_warning "Python未安装，尝试使用Node.js..."
                if check_node; then
                    start_node_server
                else
                    print_error "Python和Node.js都未安装"
                    print_info "请安装Python或Node.js后重试"
                    exit 1
                fi
            fi
            ;;
        node)
            if check_node; then
                start_node_server
            else
                print_warning "Node.js未安装，尝试使用Python..."
                if check_python; then
                    start_python_server
                else
                    print_error "Python和Node.js都未安装"
                    print_info "请安装Python或Node.js后重试"
                    exit 1
                fi
            fi
            ;;
    esac
}

# 运行主函数
main "$@"