# Stage 1: Build Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy source code
COPY . .

# Build the plugin (HPI)
RUN mvn clean package

# Stage 2: Create minimal runtime image
FROM eclipse-temurin:17-jdk

WORKDIR /jenkins-plugin

# Copy only the .hpi file from the builder stage
COPY --from=builder /app/target/*.hpi ./plugin.hpi

# Set default command
CMD ["java", "-jar", "plugin.hpi"]
