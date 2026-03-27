{{- define "mcpgate.name" -}}
{{- .Chart.Name -}}
{{- end }}

{{- define "mcpgate.fullname" -}}
{{- if contains .Chart.Name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "mcpgate.labels" -}}
app.kubernetes.io/name: {{ include "mcpgate.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{- define "mcpgate.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mcpgate.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
