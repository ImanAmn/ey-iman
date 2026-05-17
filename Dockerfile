FROM python:3.11-slim
RUN pip install pproxy
CMD ["pproxy", "-l", "http://0.0.0.0:80"]
