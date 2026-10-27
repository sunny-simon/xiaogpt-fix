FROM yihong0618/xiaogpt:latest

# 1. 自动修复 Python 3.14 下 asyncio.get_event_loop() 的报错问题
RUN sed -i 's/loop = asyncio.get_event_loop()/try:\n        loop = asyncio.get_running_loop()\n    except RuntimeError:\n        loop = asyncio.new_event_loop()\n        asyncio.set_event_loop(loop)/g' /app/xiaogpt/cli.py

# 2. 清空父镜像原有的 ENTRYPOINT，防止参数叠加冲突
ENTRYPOINT []

# 3. 指定唯一的启动指令
CMD ["python3", "-u", "/app/xiaogpt.py"]
