FROM yihong0618/xiaogpt:latest

# 1. 强制使用宽松模式安装，允许 pip 快速跳过版本死锁
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --use-pep517 "google-genai" "requests" "PyYAML" "miservice" "openai"

# 2. 自动修复 Python 3.14 下 asyncio.get_event_loop() 的报错问题
RUN sed -i 's/loop = asyncio.get_event_loop()/try:\n        loop = asyncio.get_running_loop()\n    except RuntimeError:\n        loop = asyncio.new_event_loop()\n        asyncio.set_event_loop(loop)/g' /app/xiaogpt/cli.py

# 3. 清空父镜像原有的 ENTRYPOINT，防止参数冲突
ENTRYPOINT []

# 4. 指定最终启动指令
CMD ["python3", "-u", "/app/xiaogpt.py"]
