FROM python:3.11-slim
RUN pip install pproxy
EXPOSE 80
CMD ["pproxy", "-l", "http://0.0.0.0:80", "--http", "/", "text/plain", "OK"]
