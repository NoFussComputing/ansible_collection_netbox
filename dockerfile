
FROM python:3.11-alpine3.19 as build


RUN apk update; \
  apk add gcc


RUN pip install --upgrade \
    setuptools \
    wheel


RUN apk add openjdk21-jdk;


RUN apk add \ 
    alpine-sdk \
    libffi-dev \
    maven;


ENV JAVA_HOME /usr/lib/jvm/java-21-openjdk


COPY requirements.txt /tmp/requirements.txt


RUN mkdir -p /tmp/python_modules; \
  cd /tmp/python_modules; \
  pip download --dest . --check-build-dependencies \
    supervisor==4.2.5 \
    -r /tmp/requirements.txt

RUN mkdir -p /tmp/python_builds;


RUN cd /tmp/python_modules; \
  mkdir -p /tmp/python_builds; \
  echo "[DEBUG] PATH=$PATH"; \
  pip wheel --wheel-dir /tmp/python_builds --find-links . *.whl; \
  pip wheel --wheel-dir /tmp/python_builds --find-links . *.tar.gz;


RUN echo $(date)\
  cd /tmp; \
  ls -laR /tmp




FROM python:3.11-alpine3.19

LABEL \
  # org.opencontainers.image.authors="{contributor url}" \
  # org.opencontainers.image.url="{dockerhub url}" \
  # org.opencontainers.image.documentation="{docs url}" \
  # org.opencontainers.image.source="{repo url}" \
  # org.opencontainers.image.revision="{git commit sha at time of build}" \
  org.opencontainers.image.title="No Fuss Computings NetBox to GLPI Bridge" \
  org.opencontainers.image.description="A Docker container running EDA rulebook to keep GLPI Assets in sync" \
  org.opencontainers.image.vendor="No Fuss Computing"
  # org.opencontainers.image.version="{git tag}"

RUN apk --no-cache update; \
  apk add \
    openjdk21-jdk \
    git \
    dcron \
    nmap;


ENV JAVA_HOME /usr/lib/jvm/java-21-openjdk


COPY --from=build /tmp/python_builds /tmp/python_builds


RUN chmod 644 -R /etc/cron.d; \
  pip install /tmp/python_builds/*; \
  rm -R /tmp/python_builds


ARG COLLECTION_COMMIT=none

ARG COLLECTION_BRANCH=development

ARG COLLECTION_PACKAGE=dev


COPY includes/ /

ADD ./. /tmp/collection/

RUN mkdir -p /tmp/collection; \
  if [ "$COLLECTION_PACKAGE" != "dev" ]; then \
    echo "[TRACE] Package Specified"; \
    ansible-galaxy collection install --force-with-deps --pre \
      $COLLECTION_PACKAGE; \
  elif [ "$COLLECTION_PACKAGE" == "dev" ]; then \
    echo "[TRACE] Development Build"; \
    # git clone \
    #   --depth=1 \
    #   -b $COLLECTION_BRANCH \ 
    #   https://gitlab.com/nofusscomputing/projects/ansible/collections/phpipam_scan_agent.git \
    #   /tmp/collection; \
    # if [ "${COLLECTION_COMMIT}" != "none" ]; then git switch $COLLECTION_COMMIT; fi; \
    echo "[TRACE] Installing Development Build"; \
    ansible-galaxy collection install --force-with-deps --pre \
    /tmp/collection/.; \
    rm -Rf /tmp/collection; \
  fi; \
  chmod +x /etc/cron.d/*; \
  chmod +x /bin/update-ca; \
  chown root:root -R /etc/phpipam; \
  chmod 740 -R /etc/phpipam;


WORKDIR /root


HEALTHCHECK --interval=10s --timeout=10s --start-period=5s --retries=3 CMD \
  supervisorctl status || exit 1


ENV HTTP_PORT 5000

ENV ANSIBLE_FORCE_COLOR 'true'

ENV ANSIBLE_LOG_PATH /var/log/ansible.log


CMD [ "/usr/local/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf" ]
