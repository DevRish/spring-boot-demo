cd /app 
./mvnw clean install 
mv /app/target/*.jar /app/target/app.jar 
java -jar /app/target/app.jar 