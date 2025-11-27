# Etapa 1: Build da aplicação usando Gradle FROM gradle:8.0-jdk17-jammy AS build WORKDIR /app COPY . . RUN gradle build --no-daemon Etapa 2: Imagem final com apenas o JAR FROM 
#eclipse-temurin:17-jdk-jammy WORKDIR /app COPY --from=build /app/build/libs/*.jar app.jar EXPOSE 8080 ENTRYPOINT ["java", "-jar", "app.jar"]

# Etapa 1: Build da aplicação usando Gradle 4.10 FROM gradle:4.10-jdk8 AS build WORKDIR /app COPY . . RUN gradle build --no-daemon Etapa 2: Imagem final com apenas o JAR FROM 
#openjdk:8-jdk-slim WORKDIR /app COPY --from=build /app/build/libs/*.jar app.jar EXPOSE 8080 ENTRYPOINT ["java", "-jar", "app.jar"]

# Stage 1: Build com Gradle 4.10 + JDK8 FROM gradle:4.10-jdk8 AS build WORKDIR /app COPY . . RUN gradle build --no-daemon Stage 2: runtime com JDK 8 FROM openjdk:8-jre-slim WORKDIR 
#/app COPY --from=build /app/build/libs/*.jar app.jar EXPOSE 8080 ENTRYPOINT ["java", "-jar", "app.jar"]

# Stage 1: Build com Gradle 4.10 + JDK 8 FROM gradle:4.10-jdk8 AS build WORKDIR /app COPY . . RUN gradle build --no-daemon Stage 2: Runtime com JRE 8 funcional FROM 
#eclipse-temurin:8-jre WORKDIR /app COPY --from=build /app/build/libs/*.jar app.jar EXPOSE 8080 ENTRYPOINT ["java", "-jar", "app.jar"]

# Etapa 1: build com Gradle 4.10 e JDK 8 (compatível) FROM gradle:4.10-jdk8 AS build WORKDIR /app COPY . . Gera o JAR RUN gradle build --no-daemon Etapa 2: executar com JDK 17 (mínimo 
#moderno) FROM openjdk:17-jdk-slim WORKDIR /app COPY --from=build /app/build/libs/*.jar app.jar EXPOSE 8080 ENTRYPOINT ["java", "-jar", "app.jar"]

# ============================
# Etapa 1 — Build da aplicação
# ============================
FROM gradle:8.7-jdk17 AS build

WORKDIR /home/gradle/project

COPY . .

RUN gradle clean shadowJar --no-daemon

# ============================
# Etapa 2 — Runtime
# ============================
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /home/gradle/project/build/libs/iti-kubernetes-challenge-app-1.0.0-all.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
