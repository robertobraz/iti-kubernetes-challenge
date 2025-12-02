# ============================
# Etapa 1 — Build da aplicação
# ============================
FROM gradle:8.7-jdk17 AS build

WORKDIR /home/gradle/project

# Copia tudo para dentro do container de build
COPY . .

# Gera o ShadowJar (fat jar)
RUN gradle clean shadowJar --no-daemon

# ============================
# Etapa 2 — Runtime (leve)
# ============================
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copia o jar gerado para a imagem final
COPY --from=build /home/gradle/project/build/libs/*-all.jar app.jar

# Expõe a porta padrão do Ktor
EXPOSE 8080

# Variáveis de ambiente opcionais
ENV TARGET="World"
ENV PORT=8080

# Executa o app
ENTRYPOINT ["java", "-jar", "app.jar"]
