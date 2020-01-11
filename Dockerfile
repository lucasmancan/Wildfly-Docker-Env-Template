FROM jboss/wildfly:12.0.0.Final

# ENV VARIABLES
ENV WILDFLY_HOME /opt/jboss/wildfly
ENV WILDFLY_VERSION 12.0.0.Final
ENV MYSQL_HOST XXXXXXX
ENV MYSQL_USER XXXXXXX
ENV MYSQL_PASSWORD XXXXXX
ENV MYSQL_DATABASE XXXXXX

ADD target/XXXXXX.war /opt/jboss/wildfly/standalone/deployments/

# Add standalone xml file
COPY standalone-XXXX.xml ${WILDFLY_HOME}/standalone/configuration/standalone.xml
# Get MySQL driver
ADD https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.48/mysql-connector-java-5.1.48.jar ${WILDFLY_HOME}/modules/com/mysql/jdbc/main/mysql-connector-java-5.1.48-bin.jar
# MYSQL JDBC Module
COPY module-mysql.xml ${WILDFLY_HOME}/modules/com/mysql/jdbc/main/module.xml
# Add console admin user
RUN ${WILDFLY_HOME}/bin/add-user.sh XXXXX XXXXX --silent
# Ports
EXPOSE 8080 9990
# Volumes
VOLUME ${WILDFLY_HOME}/standalone/deployments/
VOLUME ${WILDFLY_HOME}/standalone/log/
# RUN script
COPY start-wildfly.sh ${WILDFLY_HOME}/bin/start-wildfly.sh
USER root

RUN sed -i -e 's/\r$//' ${WILDFLY_HOME}/bin/start-wildfly.sh

RUN chmod +x ${WILDFLY_HOME}/bin/start-wildfly.sh
#USER jboss
#RUN sed -i -- 's/<context-root>\/api<\/context-root>/<context-root>\/erp-api<\/context-root>/g' ${WILDFLY_HOME}/standalone/deployments/erp-api-1.0.war/WEB-INF/jboss-web.xml
RUN touch ${WILDFLY_HOME}/standalone/deployments/XXXXXX.war.dodeploy


ENTRYPOINT ["sh", "-c", "${WILDFLY_HOME}/bin/start-wildfly.sh"]