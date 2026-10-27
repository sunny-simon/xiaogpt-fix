FROM yihong0618/xiaogpt:latest

# 自动修复 Python 3.14 下 asyncio.get_event_loop() 的报错问题
RUN sed -i 's/loop = asyncio.get_event_loop()/try:\n        loop = asyncio.get_running_loop()\n    except RuntimeError:\n        loop = asyncio.new_event_loop()\n        asyncio.set_event_loop(loop)/g' /app/xiaogpt/cli.py

CMD ["python3", "/app/xiaogpt.py"]
