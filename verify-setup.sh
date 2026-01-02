#!/bin/bash

# Avante RAG 服务验证脚本
# 验证系统环境和RAG服务配置

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查 Docker 是否安装
check_docker_installed() {
    if command -v docker &> /dev/null; then
        log_success "Docker 已安装"
        return 0
    else
        log_error "Docker 未安装"
        return 1
    fi
}

# 检查 Docker Compose 是否安装
check_docker_compose() {
    if command -v docker-compose &> /dev/null || docker compose version &> /dev/null; then
        log_success "Docker Compose 已安装"
        return 0
    else
        log_error "Docker Compose 未安装"
        return 1
    fi
}

# 检查 Docker 是否运行
check_docker_running() {
    if docker info > /dev/null 2>&1; then
        log_success "Docker 正在运行"
        return 0
    else
        log_error "Docker 未运行，请启动 Docker Desktop"
        return 1
    fi
}

# 检查必要文件是否存在
check_required_files() {
    local missing_files=()

    if [[ ! -f "docker-compose.yml" ]]; then
        missing_files+=("docker-compose.yml")
    fi

    if [[ ! -f "start-rag-service.sh" ]]; then
        missing_files+=("start-rag-service.sh")
    fi

    if [[ ${#missing_files[@]} -gt 0 ]]; then
        log_error "缺少必要文件: ${missing_files[*]}"
        return 1
    else
        log_success "所有必要文件都存在"
        return 0
    fi
}

# 检查 API 密钥环境变量
check_api_keys() {
    local missing_keys=()

    if [[ -z "${OPEN_SOURCE_API_KEY:-}" ]]; then
        missing_keys+=("OPEN_SOURCE_API_KEY")
    fi

    if [[ -z "${SILICONFLOW_API_KEY:-}" ]]; then
        missing_keys+=("SILICONFLOW_API_KEY")
    fi

    if [[ -z "${TAVILY_API_KEY:-}" ]]; then
        missing_keys+=("TAVILY_API_KEY")
    fi

    if [[ ${#missing_keys[@]} -gt 0 ]]; then
        log_warning "以下 API 密钥未设置: ${missing_keys[*]}"
        log_warning "请添加到 ~/.zshrc 或 ~/.bashrc:"
        echo ""
        for key in "${missing_keys[@]}"; do
            echo "export $key=\"your_api_key_here\""
        done
        echo ""
        log_warning "然后运行: source ~/.zshrc"
        return 1
    else
        log_success "所有必需的 API 密钥已配置"
        return 0
    fi
}

# 检查 RAG 服务状态
check_rag_service() {
    log_info "检查 RAG 服务状态..."

    # 检查容器是否运行
    if docker ps | grep -q "avante-rag-service"; then
        log_success "RAG 服务容器正在运行"

        # 检查服务健康状态
        if curl -f http://localhost:20250/health > /dev/null 2>&1; then
            log_success "RAG 服务健康检查通过"
            return 0
        else
            log_warning "RAG 服务容器运行但健康检查失败"
            return 1
        fi
    else
        log_warning "RAG 服务容器未运行"
        return 1
    fi
}

# 检查 Ollama 服务状态
check_ollama_service() {
    log_info "检查 Ollama 服务状态..."

    # 检查容器是否运行
    if docker ps | grep -q "ollama-service"; then
        log_success "Ollama 服务容器正在运行"

        # 检查 Ollama API
        if curl -f http://localhost:11434/api/tags > /dev/null 2>&1; then
            log_success "Ollama API 响应正常"
            return 0
        else
            log_warning "Ollama 容器运行但 API 无响应"
            return 1
        fi
    else
        log_warning "Ollama 服务容器未运行"
        return 1
    fi
}

# 主验证函数
main_verification() {
    echo -e "${BLUE}=== Avante RAG 服务系统验证 ===${NC}"
    echo ""

    # 验证系统环境
    echo -e "${BLUE}[1/6] 验证系统环境${NC}"
    check_docker_installed
    check_docker_compose
    check_docker_running
    echo ""

    # 验证配置文件
    echo -e "${BLUE}[2/6] 验证配置文件${NC}"
    check_required_files
    echo ""

    # 验证 API 密钥
    echo -e "${BLUE}[3/6] 验证 API 密钥${NC}"
    check_api_keys
    echo ""

    # 验证 Docker Compose 配置
    echo -e "${BLUE}[4/6] 验证 Docker Compose${NC}"
    if docker-compose config -q; then
        log_success "Docker Compose 配置验证通过"
    else
        log_error "Docker Compose 配置有误"
    fi
    echo ""

    # 验证服务状态
    echo -e "${BLUE}[5/6] 验证服务状态${NC}"
    check_ollama_service
    check_rag_service
    echo ""

    # 最终建议
    echo -e "${BLUE}[6/6] 验证完成${NC}"
    if check_rag_service && check_ollama_service; then
        log_success "✅ 所有验证通过！RAG 服务已准备就绪"
        echo ""
        echo "🎯 使用方法:"
        echo "   • 手动启动: ./start-rag-service.sh start"
        echo "   • 检查状态: ./start-rag-service.sh status"
        echo "   • 停止服务: ./start-rag-service.sh stop"
    else
        log_warning "⚠️  部分验证未通过，请查看上述警告信息"
        echo ""
        echo "🔧 修复建议:"
        echo "   • 运行: ./start-rag-service.sh start"
        echo "   • 或手动启动: docker-compose up -d"
    fi
    echo ""
}

# 如果是直接执行脚本，则运行主验证函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_verification
fi

