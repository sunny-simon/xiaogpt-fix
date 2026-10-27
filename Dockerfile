FROM yihong0618/xiaogpt:latest

# 1. 完整安装 xiaogpt 及其全套依赖
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -e .

# 2. 自动修复 Python 3.14 下 asyncio.get_event_loop() 的报错问题
RUN sed -i 's/loop = asyncio.get_event_loop()/try:\n        loop = asyncio.get_running_loop()\n    except RuntimeError:\n        loop = asyncio.new_event_loop()\n        asyncio.set_event_loop(loop)/g' /app/xiaogpt/cli.py

# 3. 清空父镜像原有的 ENTRYPOINT
ENTRYPOINT []

# 4. 使用 shell 形式启动，强制把 Render 里的 COOKIE 变量传给程序
CMD sh -c "python3 -u /app/xiaogpt.py --cookie \"$COOKIE\""
