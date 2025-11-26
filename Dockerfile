# Use TomEE 8.0.1 Plume with JDK 8 (compatible with Java 8 compiled classes)
FROM tomee:8-jre-8.0.1-plume

# Remove default applications
RUN rm -rf /usr/local/tomee/webapps/*

# Copy the WAR file to TomEE's webapps directory
COPY dist/airbnb.war /usr/local/tomee/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start TomEE
CMD ["catalina.sh", "run"]
