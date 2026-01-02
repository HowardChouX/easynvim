#!/bin/bash

# Avante RAG 服务自动启动脚本
# 此脚本会自动检查、启动和管理 RAG 服务

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

# 检查 Docker 是否运行
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        log_error "Docker 未运行，请启动 Docker Desktop"
        return 1
    fi
    log_success "Docker 正在运行"
    return 0
}

# 检查 API 密钥
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
        log_warning "虽然可以继续，但某些功能可能无法正常工作"
    else
        log_success "所有必需的 API 密钥已配置"
    fi
}

# 检查服务状态
check_service_status() {
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

# 启动服务
start_service() {
    log_info "启动 RAG 服务..."

    # 检查是否已存在容器
    if docker ps -a | grep -q "avante-rag-service"; then
        log_info "清理旧容器..."
        docker-compose down
    fi

    # 启动服务
    if docker-compose up -d; then
        log_success "RAG 服务启动成功"

        # 等待服务启动
        log_info "等待服务就绪..."
        sleep 10

        # 检查服务状态
        if check_service_status; then
            log_success "RAG 服务已就绪并可以正常工作"
        else
            log_warning "服务启动但健康检查可能需要更多时间"
        fi
    else
        log_error "RAG 服务启动失败"
        return 1
    fi
}

# 停止服务
stop_service() {
    log_info "停止 RAG 服务..."
    docker-compose down
    log_success "RAG 服务已停止"
}

# 重启服务
restart_service() {
    log_info "重启 RAG 服务..."
    stop_service
    sleep 2
    start_service
}

# 显示服务状态
status_service() {
    echo -e "${BLUE}=== RAG 服务状态 ===${NC}"

    # Docker 状态
    if check_docker; then
        echo -e "${GREEN}✓ Docker: 运行中${NC}"
    else
        echo -e "${RED}✗ Docker: 未运行${NC}"
        return 1
    fi

    # API 密钥状态
    check_api_keys

    # 服务状态
    if check_service_status; then
        echo -e "${GREEN}✓ RAG 服务: 健康${NC}"
    else
        echo -e "${RED}✗ RAG 服务: 异常或未运行${NC}"
    fi

    # 显示容器信息
    echo -e "${BLUE}容器状态:${NC}"
    docker-compose ps
}

# 主函数
main() {
    local command="${1:-start}"

    case "$command" in
        start)
            if check_docker; then
                check_api_keys
                if ! check_service_status; then
                    start_service
                else
                    log_success "RAG 服务已在运行"
                fi
            fi
            ;;
        stop)
            stop_service
            ;;
        restart)
            restart_service
            ;;
        status)
            status_service
            ;;
        *)
            echo "用法: $0 {start|stop|restart|status}"
            echo "  start   - 启动 RAG 服务"
            echo "  stop    - 停止 RAG 服务"
            echo "  restart - 重启 RAG 服务"
            echo "  status  - 检查服务状态"
            exit 1
            ;;
    esac
}

# 如果是直接执行脚本，则运行主函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

