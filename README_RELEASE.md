🚀 Visão Geral 

Este documento descreve como executar o projeto entregue referente à Fase 1 do desafio Kubernetes. 
Aqui você encontrará os comandos essenciais para: 

Construir a imagem da aplicação 

Rodar no Minikube 

Instalar via Helm 

Validar o funcionamento 

A pasta .git está incluída para permitir análise completa do histórico de commits. 

 

📦 1. Pré-requisitos 

Antes de executar a solução, instale: 

Docker 

Minikube 

Kubectl 

Helm 

JDK (somente se quiser rodar o app localmente) 

Verifique: 

docker --version 
minikube version 
kubectl version --client 
helm version 
 

 

🏗 2. Build da imagem da aplicação 

Acesse a pasta raiz do projeto: 

cd iti-kubernetes-challenge 
 

Dentro dela, faça o build da imagem localmente: 

docker build -t app-kotlin:latest . 
 

 

🧪 3. Teste opcional em Docker local 

docker run -p 8080:8080 app-kotlin:latest 
 

Acesse: 
http://localhost:8080 

 

☸️ 4. Inicializar o Minikube 

minikube start 
 

Verifique: 

kubectl get nodes 
 

 

📥 5. Carregar a imagem no Minikube 

minikube image load app-kotlin:latest 
 

 

🛠 6. Instalar via Helm 

Acesse o diretório: 

cd helm 
 

Instale o chart: 

helm install app . 
 

Verifique: 

kubectl get pods 
kubectl get svc 
 

 

🌐 7. Acessar a aplicação 

Com Minikube: 

minikube service app 
 

Esse comando irá abrir a aplicação no navegador. 

 

🔍 8. Logs e validação 

Ver logs: 

kubectl logs -l app=app 
 

Ver pods: 

kubectl get pods -o wide 
 

 

🗑 9. Remoção/limpeza 

Para remover a aplicação: 

helm uninstall app 
 

Para parar o cluster: 

minikube stop 
 

 

📚 Estrutura do Projeto (Fase 1) 

/iti-kubernetes-challenge 
│ 
├── app/                # Código da aplicação (Kotlin) 
├── helm/               # Helm chart completo 
├── terraform/          # Infra mínima do desafio 
├── Dockerfile          # Build da imagem 
├── README.md           # Documentação geral 
├── README_RELEASE.md   # Este documento 
└── .git/               # Histórico de commits conforme solicitado 
 

 

🎯 Status da Entrega 

A Fase 1 foi entregue integralmente: 

Aplicação Kotlin funcional 

Dockerfile 

Manifests Kubernetes 

Helm Chart 

Terraform básico 

Execução validada no Minikube 

Histórico Git incluso conforme solicitado 

As Fases 2 e 3 já foram documentadas separadamente como roadmap de melhorias. 

 

📩 Contato 

Em caso de dúvidas, estou à disposição para esclarecimentos adicionais. 