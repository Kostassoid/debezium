FROM registry.access.redhat.com/ubi8/openjdk-11

LABEL maintainer="Hello Fresh"

#
# Set the version and home directory
#
ENV DEBEZIUM_VERSION=1.7.2.Final \
    SERVER_HOME=/debezium
ENV SERVER_URL_PATH=io/debezium/debezium-server-dist/$DEBEZIUM_VERSION/debezium-server-dist-$DEBEZIUM_VERSION.tar.gz

#
# Create a directory for Debezium Server
#
USER root
RUN microdnf -y install gzip && \
    microdnf clean all && \
    mkdir $SERVER_HOME && \
    chmod 755 $SERVER_HOME

#
# Change ownership and switch user
#
RUN chown -R jboss $SERVER_HOME && \
    chgrp -R jboss $SERVER_HOME
USER jboss

RUN mkdir $SERVER_HOME/conf && \
    mkdir $SERVER_HOME/data

COPY debezium-server/debezium-server-dist/target/debezium-server-dist-$DEBEZIUM_VERSION.tar.gz /tmp/debezium.tar.gz

#RUN tar xzf /tmp/debezium.tar.gz -C $SERVER_HOME --strip-components 1 &&\
#    rm -f /tmp/debezium.tar.gz

RUN tar xzf /tmp/debezium.tar.gz -C $SERVER_HOME --strip-components 1

#
# Allow random UID to use Debezium Server
#
RUN chmod -R g+w,o+w $SERVER_HOME

# Set the working directory to the Debezium Server home directory
WORKDIR $SERVER_HOME

#
# Expose the ports and set up volumes for the data, transaction log, and configuration
#
EXPOSE 8080
VOLUME ["/debezium/conf","/debezium/data"]

CMD ["/debezium/run.sh"]