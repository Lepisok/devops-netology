FROM centos:7

RUN adduser --uid 1000 opensearch && \
    mkdir -p /var/lib/opensearch/log && \
    mkdir -p /var/lib/opensearch/data && \
    mkdir -p /var/lib/opensearch/snapshots && \
    chown opensearch:opensearch -R /var/lib/opensearch/log && \
    chown opensearch:opensearch -R /var/lib/opensearch/data && \
    chown opensearch:opensearch -R /var/lib/opensearch/snapshots

RUN yum update -y && \
    yum install wget -y && \
    wget https://artifacts.opensearch.org/releases/bundle/opensearch/2.3.0/opensearch-2.3.0-linux-x64.tar.gz && \
    tar -xvf opensearch-2.3.0-linux-x64.tar.gz && \
    rm -f opensearch-2.3.0-linux-x64.tar.gz

COPY opensearch.yml /opensearch-2.3.0/config

RUN chown opensearch:opensearch /opensearch-2.3.0/config/opensearch.yml

EXPOSE 9200

EXPOSE 9300

CMD ["bin/opensearch"]
