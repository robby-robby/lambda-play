FROM public.ecr.aws/lambda/nodejs:18

# Install chromium dependencies
RUN yum install -y wget xz unzip libXcomposite

RUN yum install -y \
    atk \
    cups-libs \
    dbus-glib \
    alsa-lib \
    gtk3 \
    ipa-gothic-fonts \
    xorg-x11-font-util \
    xorg-x11-fonts-100dpi \
    xorg-x11-fonts-75dpi \
    xorg-x11-utils \
    xorg-x11-fonts-cyrillic \
    xorg-x11-fonts-Type1 \
    xorg-x11-fonts-misc \
    GConf2 \
    libXcomposite \
    libXcursor \
    libXdamage \
    libXext \
    libXi \
    libXtst \
    libXrandr \
    libXScrnSaver \
    libXinerama \
    libxkbcommon-x11 \
    pangox-compat \
    pango \
    libXrender \
    fontconfig
# Copy function code
COPY package*.json ${LAMBDA_TASK_ROOT}

RUN npm install

RUN npx playwright install

# RUN npx playwright install-deps


# Copy handler
COPY index.js ${LAMBDA_TASK_ROOT}

# Set the CMD to index.handler
CMD [ "index.handler" ]

