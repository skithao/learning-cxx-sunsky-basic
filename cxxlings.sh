#!/bin/bash

# 定义颜色
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# 获取终端的列数
terminal_width=$(tput cols)

# 检查并安装依赖
install_dependencies() {
    if ! command -v figlet &> /dev/null; then
        echo "${RED}figlet 未安装，正在尝试安装...${RESET}"
        sudo apt-get install -y figlet || sudo snap install figlet
    fi
    if ! command -v cowsay &> /dev/null; then
        echo "${RED}cowsay 未安装，正在尝试安装...${RESET}"
        sudo apt-get install -y cowsay || sudo snap install cowsay
    fi
    if ! command -v lolcat &> /dev/null; then
        echo "${RED}lolcat 未安装，正在尝试安装...${RESET}"
        sudo apt-get install -y lolcat || sudo snap install lolcat
    fi
}

# 检查并安装xmake
install_xmake() {
    if ! command -v xmake &> /dev/null; then
        echo "${RED}xmake 未安装，正在安装...${RESET}"
        sudo wget https://xmake.io/shget.text -O - | bash
        sudo mv xmake /usr/local/bin/
        sudo chmod +x /usr/local/bin/xmake
        source ~/.bashrc
    fi
}

# 检查并编译 xmake 目标
check_and_build() {
    install_xmake
    if ! xmake; then
        echo "${RED}构建失败，请检查项目配置！${RESET}"
        exit 1
    fi
}

# 调用函数检查并安装依赖
install_dependencies
# 调用函数检查并编译目标
check_and_build

# 输出欢迎信息
echo -e "${GREEN}$(figlet "C x x l i n g s" | lolcat)${RESET}"
echo -e "${GREEN}$(cowsay "欢迎使用Cxxlings-sunsky刷题版~~~" | lolcat)${RESET}"

# 运行测试的总题数
total_exercises=30
completed=0

# 循环从00到29
for i in $(seq -f "%02g" 0 29)
do
    echo -n "${GREEN}正在测试 第 $i 题... ${RESET}"
    # 执行测试命令并捕获输出
    output=$(xmake run learn $i 2>&1) # 捕获标准输出和标准错误
    
    # 检查输出中是否有失败的信息
    if echo "$output" | grep -q "exercise${i} failed"; then
        echo "${RED}$output${RESET}" # 输出捕获的信息
        break # 退出脚本，返回状态码1表示错误
    else
        echo "${GREEN}通过${RESET}"
        completed=$((completed + 1))  # 正确测试则增加完成计数
    fi

    # 更新进度条
    percent=$((completed * 100 / total_exercises))
    # 计算进度条长度
    progress_length=$(((terminal_width - 20) * completed / total_exercises))
    # 生成进度条
    progress=$(printf "%-${progress_length}s" | tr ' ' '#')
    progress_bar="${GREEN}${progress}${RESET}"
    printf "\r进度: [%-*s] %d%%\n" "$((terminal_width - 12))" "$progress_bar" "$percent"
done

# 检查是否完成所有测试
if [ "$completed" -eq "$total_exercises" ]; then
    figlet "Yes C++!" | lolcat
    echo "${GREEN}所有测试完成！好耶~~~${RESET}"
else
    cowthink "革命尚未完成，加油哇QAQ" | lolcat
    echo "${RED}测试失败！请检查第 $((completed)) 题！${RESET}"
fi

exit 0 # 退出脚本，返回状态码0表示成功