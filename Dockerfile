# 使用官方 Jekyll 镜像作为基础镜像
FROM jekyll/jekyll:4.2.0

# 设置容器内的工作目录
# 所有后续命令都会在这个目录下执行
WORKDIR /srv/jekyll

# 将当前目录的所有文件复制到容器的 /srv/jekyll 目录
# 第一个 . 表示宿主机当前目录（您的博客目录）
# 第二个 . 表示容器内的当前目录（/srv/jekyll）
COPY . .

# 安装 Gemfile 中指定的依赖（如果存在 Gemfile）
# bundle install 会读取 Gemfile 并安装所有 gem 包
RUN bundle install

# 构建静态网站
# jekyll build 命令会将 Markdown 文件转换为 HTML 静态文件
RUN jekyll build

# 暴露端口 4000
# Jekyll 默认开发服务器运行在 4000 端口
EXPOSE 4000

# 容器启动时执行的命令
# jekyll serve --host 0.0.0.0 让服务器监听所有网络接口
# --force_polling 确保文件变化能够被检测到
CMD ["jekyll", "serve", "--host", "0.0.0.0", "--force_polling"]
