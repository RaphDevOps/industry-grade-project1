# Using the official Tomcat image which includes OpenJDK
FROM tomcat:9.0-jdk11-openjdk-slim

# Remove any default apps in the webapps directory
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file into the Tomcat webapps directory, renaming it to ROOT.war to make it the default app
COPY ./ABCtechnologies-1.0.war /usr/local/tomcat/webapps/ROOT.war

# Set any environment variables, if necessary
ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Xms512m -Xmx1024m"

# Expose port 8080 for HTTP traffic
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]


