FROM eclipse-temurin:17-jdk-alpine

# Never terminating command to keep the container alive in detached mode
CMD ["tail", "-f","/dev/null"]