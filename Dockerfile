FROM jlesage/baseimage-gui:ubuntu-22.04-v4.8.2

ARG MOTRIX_VERSION=1.8.19
ENV MOTRIX_VERSION=${MOTRIX_VERSION} \
    MOTRIX_DOWNLOAD_URL=https://github.com/agalwood/Motrix/releases/download/v${MOTRIX_VERSION}/Motrix-${MOTRIX_VERSION}-arm64.AppImage \
    APP_NAME="Motrix VNC" 

ENV LC_ALL=C

RUN \

    apt-get update && \
    
    add-pkg --virtual build-dependencies wget ca-certificates && \

    add-pkg fonts-wqy-zenhei && \

    add-pkg \
        libgtk-3-dev \
        libgtk-3-0 \
        libglib2.0-0 \
        libgdk-pixbuf2.0-0 \
        libx11-6 \
        libxcomposite1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        libnss3 \
        libasound2 \
        libdrm2 \
        fonts-liberation && \
    
    mkdir -p /opt/motrix-appimage && \
    wget -O /opt/motrix-appimage/Motrix.AppImage "${MOTRIX_DOWNLOAD_URL}" && \
    chmod +x /opt/motrix-appimage/Motrix.AppImage && \
    
    cd /opt/ && \
    /opt/motrix-appimage/Motrix.AppImage --appimage-extract && \
    mv /opt/squashfs-root /opt/motrix && \
    
    chmod -R a+x /opt/motrix && \
    
    set-cont-env APP_NAME "${APP_NAME}" && \
    
    del-pkg build-dependencies && \
    rm -rf /opt/motrix-appimage && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY rootfs/ /

RUN \
   APP_ICON_URL=https://raw.githubusercontent.com/agalwood/Motrix/master/static/mo-tray-colorful-normal.png && \
   install_app_icon.sh "$APP_ICON_URL"