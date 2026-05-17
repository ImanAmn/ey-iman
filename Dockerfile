FROM alpine:latest

# نصب ابزار xray برای پروتکل تروجان
RUN apk add --no-cache curl unzip && \
    curl -L -H "Cache-Control: no-cache" -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/xray && \
    rm -rf /tmp/*

# کانفیگ تروجان روی وب‌ساکت هماهنگ با پورت 80 بک‌فوراپ
RUN echo '{\
  "inbounds": [{\
    "port": 80,\
    "protocol": "trojan",\
    "settings": {\
      "clients": [{"password": "iman_secret_pass_2026"}]\
    },\
    "streamSettings": {\
      "network": "ws",\
      "wsSettings": {"path": "/tunnel"}\
    }\
  }],\
  "outbounds": [{"protocol": "freedom"}]\
}' > /usr/local/bin/config.json

EXPOSE 80
CMD ["/usr/local/bin/xray", "-config", "/usr/local/bin/config.json"]
