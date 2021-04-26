FROM ubuntu:bionic
COPY image_files/ /

RUN apt-get update -y \
    && apt-get install -y \
    default-jre apt-transport-https wget gnupg curl vim \
    && wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - \
    && echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list \
    && apt-get update -y \
    && apt-get install -y kibana

CMD /start.sh
