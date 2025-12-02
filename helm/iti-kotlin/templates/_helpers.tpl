{{/*
Normalized chart name
*/}}
{{- define "iti-kotlin.name" -}}
{{- .Chart.Name | replace "+" "_" -}}
{{- end }}

{{/*
Fully qualified app name
*/}}
{{- define "iti-kotlin.fullname" -}}
{{- $name := include "iti-kotlin.name" . -}}
{{- if .Release.Name }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{- $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{/*
Standard Helm/Kubernetes labels
*/}}
{{- define "iti-kotlin.labels" -}}
helm.sh/chart: {{ include "iti-kotlin.name" . }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ include "iti-kotlin.name" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels - must be stable
*/}}
{{- define "iti-kotlin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "iti-kotlin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
