Desafio Kubernetes ITI 

📌 Visão Geral 

Este repositório contém a aplicação Kotlin + API REST e todo o conjunto de artefatos necessários para executar a aplicação em um cluster Kubernetes local utilizando Minikube. A solução atende ao desafio inicial (Fase 1) e já está preparada para evoluções profissionais previstas nas Fases 2 e 3. 

🟦 Fase 1 — Escopo do Desafio Atendido 

Esta fase corresponde à entrega mínima solicitada pelo desafio técnico. 
Os seguintes itens foram concluídos: 

✔ Aplicação Kotlin desenvolvida 

API REST simples retornando Hello World na porta 8080. 

✔ Dockerfile criado 

Build da imagem da aplicação com base no JDK apropriado. 

Artefato funcionando localmente via Docker. 

✔ Deploy no Kubernetes com manifests 

Deployment funcional. 

Service expondo a aplicação dentro do cluster. 

✔ Helm Chart criado 

Chart básico encapsulando Deployment + Service. 

Instalação funcional via: 

helm install app ./chart 
 

 

✔ Terraform configurando recursos 

Integração para provisionamento mínimo necessário. 

✔ Execução completa no Minikube 

Aplicação acessível e totalmente funcional. 

Conclusão da Fase 1 
Entrega concluída, funcional e alinhada ao solicitado no enunciado do desafio técnico. 

 

🟩 Fase 2 — Melhorias 

Baseado nas melhores práticas DevOps e SRE, foram definidos 5 incrementos para elevar o nível técnico: 

1️⃣ Ingress Controller 

Adicionar Ingress para expor a aplicação com roteamento HTTP/HTTPS profissional. 

2️⃣ Liveness & Readiness Probes 

Garantir saúde, resiliência, autorecuperação e controle de tráfego. 

3️⃣ Parametrização por Ambiente 

Valores dinâmicos no Helm/Terraform para dev, stage e prod. 

4️⃣ Publicação da Imagem em Registry 

Build → tag → push no Docker Hub e uso no cluster. 

5️⃣ Pipeline CI/CD 

Pipeline automatizando: 

testes 

build 

push da imagem 

deploy via Helm/Terraform 

Ponto importante: 
Essas melhorias mostram maturidade técnica e entendimento profissional de arquitetura moderna. 

 

🟧 Fase 3 — Elevação SRE (9 melhorias identificadas) 

Além das melhorias da Fase 2, foram levantadas recomendações SRE adicionais: 

✔ 1. HPA (Horizontal Pod Autoscaler) 

✔ 2. Resource Requests e Limits 

✔ 3. ServiceMonitor / métricas (Prometheus) 

✔ 4. Logs estruturados 

✔ 5. TLS no Ingress 

✔ 6. Secrets e ConfigMaps organizados 

✔ 7. Alertas por métricas chave 

✔ 8. Policies (PSP/PodSecurity Standards) 

✔ 9. Observabilidade completa (Grafana) 

Estas evoluções consolidam o projeto como nível produção, seguindo pilares SRE: 
Confiabilidade, escalabilidade, automação e visibilidade. 

 

🗂 Diagramas da Arquitetura 

1) Diagrama geral Kubernetes (ASCII) 

                       [ User ] 
                           | 
                           v 
                  +----------------+ 
                  |    Ingress     |  ← (Fase 2) 
                  +----------------+ 
                           | 
                           v 
                  +----------------+ 
                  |    Service     | 
                  |  (ClusterIP)   | 
                  +----------------+ 
                           | 
                           v 
                  +----------------+ 
                  |   Deployment   | 
                  |   + Pods       | 
                  +----------------+ 
                           | 
                           v 
                  +----------------+ 
                  | Docker Image   | 
                  |   (Registry)   | ← (Fase 2) 
                  +----------------+ 
 

 

2) Diagrama DevOps / CI-CD 

Developer ---> GitHub Repo 
                   | 
                   v 
           GitHub Actions Pipeline 
         ------------------------------------- 
         | Testes | Build | Docker Push | Helm | 
         ------------------------------------- 
                   | 
                   v 
              Kubernetes Cluster 
 

 

3) Diagrama completo SRE-ready (Fase 3) 

           ┌──────────────────────────┐ 
           │          Ingress                   │ 
           └────────────┬─────────────┘ 
                             │ 
                             ▼ 
     ┌──────────────────────────────────┐ 
     │         Service (ClusterIP)                   │ 
     └─────────────────┬────────────────┘ 
                  	      │ 
                              ▼ 
         ┌──────────────────────────────┐ 
         │        Deployment + Pods     	    │ 
         │  - Probes                    	    │ 
         │  - Resources                 	    │ 
         │  - HPA                		    │ 
         └──────────────┬───────────────┘ 
                              │ 
                              │ Logs/Metrics 
                              ▼ 
         ┌────────────────────────────────┐ 
         │ Prometheus + Grafana (Observ.)	       │ 
         └────────────────────────────────┘ 
 