## See here for image contents: https://github.com/microsoft/vscode-dev-containers/blob/v0.163.0/containers/python-3/.devcontainer/base.Dockerfile
ARG VARIANT="3"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}

# [Optional] Allow the vscode user to pip install globally w/o sudo
ENV PIP_TARGET=/usr/local/pip-global
ENV PYTHONPATH=${PIP_TARGET}:${PYTHONPATH}
ENV PATH=${PIP_TARGET}/bin:${PATH}
RUN if ! cat /etc/group | grep -e "^pip-global:" > /dev/null 2>&1; then groupadd -r pip-global; fi \
    && usermod -a -G pip-global vscode \
    && umask 0002 && mkdir -p ${PIP_TARGET} \
    && chown :pip-global ${PIP_TARGET} \
    && ( [ ! -f "/etc/profile.d/00-restore-env.sh" ] || sed -i -e "s/export PATH=/export PATH=\/usr\/local\/pip-global:/" /etc/profile.d/00-restore-env.sh )

# [Option] Install Node.js
# ARG INSTALL_NODE="true"
# ARG NODE_VERSION="lts/*"
# RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Optional] If your pip requirements rarely change, uncomment this section to add them to the image.
# COPY requirements.txt /tmp/pip-tmp/
# RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
#    && rm -rf /tmp/pip-tmp

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

# Create directories and set permissions
RUN mkdir /etc/odoo /opt/odoo /opt/odoo/scripts \
    && chown -R vscode:vscode /etc/odoo /opt/odoo

WORKDIR /opt/odoo

# Install Odoo
USER vscode
ARG ODOO_VERSION="master"
RUN git clone --branch=${ODOO_VERSION} --depth=1 https://github.com/odoo/odoo.git odoo
USER root

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
# https://github.com/odoo/docker/blob/master/14.0/Dockerfile
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
        build-essential fonts-noto-cjk libldap2-dev libsasl2-dev \
        postgresql-client \
        python3-dev python3-lxml python3-num2words python3-pdfminer python3-phonenumbers python3-pip \
        python3-pyldap python3-qrcode python3-renderpm python3-setuptools python3-slugify \
        python3-vobject python3-watchdog python3-xlrd python3-xlwt

# Install dependencies
# RUN pip3 --disable-pip-version-check --no-cache-dir install -r odoo/requirements.txt
RUN sudo pip3 --disable-pip-version-check --no-cache-dir install -r odoo/requirements.txt

# Install wkhtmltopdf
# See also: https://www.odoo.com/documentation/master/administration/install/install.html#dependencies
# > Important
# > wkhtmltopdf is not installed through pip and must be installed manually in version 0.12.5 for it to support headers and footers.
# > See our wiki for more details on the various versions. 
# > [version 0.12.5] https://github.com/wkhtmltopdf/wkhtmltopdf/releases/tag/0.12.5
# > [our wiki] https://github.com/odoo/odoo/wiki/Wkhtmltopdf
RUN curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb \
    && echo 'ea8277df4297afc507c61122f3c349af142f31e5 wkhtmltox.deb' | sha1sum -c - \
    && apt-get install -y --no-install-recommends ./wkhtmltox.deb \
    && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# Right-to-left interface support
# See also: https://www.odoo.com/documentation/master/administration/install/install.html#dependencies
ARG SUPPORT_RTLCSS="true"
RUN if [ "${SUPPORT_RTLCSS}" = "true" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install lts/* && npm install -g rtlcss 2>&1"; fi

# Install pylint odoo plugin https://github.com/OCA/pylint-odoo
# See also: https://odoo-development.readthedocs.io/en/latest/ide/emacs/pylint.html
RUN pip3 --disable-pip-version-check --no-cache-dir install --upgrade git+https://github.com/oca/pylint-odoo.git
#RUN pip3 --disable-pip-version-check --no-cache-dir install --upgrade --pre pylint-odoo
COPY odoo/.pylintrc /home/vscode
RUN chown vscode:vscode /home/vscode/.pylintrc

# Install bobtemplates.odoo.
# See also: https://github.com/acsone/bobtemplates.odoo
RUN pip3 --disable-pip-version-check --no-cache-dir install --upgrade bobtemplates.odoo

# Define runtime configuration
COPY odoo/entrypoint.sh /opt/odoo
COPY odoo/scripts/* /opt/odoo/scripts
COPY odoo/odoo.conf /etc/odoo
RUN chown vscode:vscode /etc/odoo/odoo.conf

USER vscode
RUN mkdir /opt/odoo/data /opt/odoo/custom_addons \
    /opt/odoo/.vscode /home/vscode/.vscode-server
USER root

ENV ODOO_RC /etc/odoo/odoo.conf
ENV PATH="/opt/odoo/scripts:${PATH}"

EXPOSE 8069 8072
ENTRYPOINT ["/opt/odoo/entrypoint.sh"]
CMD ["odoo"]
