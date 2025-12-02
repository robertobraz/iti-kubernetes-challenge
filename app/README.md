# ITI Kubernetes Challenge

Este repositório contém a aplicação Kotlin do desafio técnico de Kubernetes, com evolução para práticas de SRE e observabilidade.

---

## ?? Fase 1 — Escopo do Desafio

Entrega mínima solicitada:

- **Aplicação Kotlin**  
  API REST simples retornando Hello World na porta 8080.
- **Dockerfile**  
  Build da imagem e execução local com Docker.
- **Deploy no Kubernetes**  
  Deployment e Service básicos funcionando no cluster.
- **Helm Chart**  
  Chart encapsulando Deployment + Service, instalável via Helm.
- **Terraform**  
  Provisionamento mínimo necessário.
- **Minikube**  
  Aplicação acessível localmente.

Status: ? Concluído, funcional e alinhado ao enunciado.

---

## ?? Fase 2 — Melhorias (Melhores Práticas DevOps)

Incrementos aplicados:

1. **Ingress Controller**  
   Exposição da aplicação com roteamento HTTP/HTTPS profissional.
2. **Liveness & Readiness Probes**  
   Garantia de saúde, resiliência e autorecuperação.
3. **Parametrização por Ambiente**  
   Valores dinâmicos no Helm/Terraform (dev, stage, prod).
4. **Publicação de Imagem em Registry**  
   Build ? tag ? push no Docker Hub ? uso no cluster.
5. **Pipeline CI/CD**  
   Automação de testes, build, push da imagem e deploy via Helm/Terraform.

Status: ? Implementado.

---

## ?? Fase 3 — Elevação SRE e Observabilidade

Melhorias adicionais:

- **HPA (Horizontal Pod Autoscaler)**  
  Escalabilidade automática baseada em métricas de CPU/memória.
- **Resource Requests e Limits**  
  Controle de recursos por Pod.
- **ServiceMonitor / Métricas Prometheus**  
  Monitoramento completo da aplicação e cluster.
- **Logs Estruturados**  
  Logs padronizados e organizados.
- **TLS no Ingress**  
  Comunicação segura.
- **Secrets e ConfigMaps organizados**  
  Configuração centralizada e segura.
- **Alertas por Métricas Chave**  
  Integração com Prometheus/Alertmanager.
- **Policies (PSP/PodSecurity Standards)**  
  Segurança reforçada no cluster.
- **Observabilidade Completa (Grafana)**  
  Dashboards configurados e funcionando.

Status: ? Implementado.

---

## ? Acesso às Ferramentas

- **Grafana**:  
  \\\ash
  kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring
  \\\  
  Usuário: dmin  
  Senha: definida no Secret grafana-admin.

- **Prometheus**:  
  \\\ash
  kubectl port-forward svc/prometheus-kube-prometheus-prometheus 9090:9090 -n monitoring
  \\\

---

## ?? Estrutura do Repositório

\\\
app/                  # Código Kotlin
helm/iti-kotlin/      # Helm chart
scripts/              # Scripts de monitoramento HPA
Dockerfile            # Imagem da aplicação
build.gradle.kts      # Build Kotlin
\\\

---

## ?? Próximos Passos

O projeto agora está pronto com as melhorias de SRE/observabilidade. Futuras evoluções podem incluir:

- Integração de alertas avançados e notificações
- Mais métricas customizadas
- Pipeline CI/CD completo com GitHub Actions ou Jenkins
- Deploy multi-ambiente automatizado

---

## ?? Observações

Todas as práticas aplicadas seguem princípios de confiabilidade, escalabilidade, automação e visibilidade.
