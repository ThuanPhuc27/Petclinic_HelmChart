{{- define "common.ingress" -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
    name: "{{ .Values.appName }}-ingress"
    namespace: {{ .Release.Namespace }}
    annotations:
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
      cert-manager.io/cluster-issuer: "letsencrypt-prod"
      nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  {{- if .Values.ingress.tls }}
  tls:
    {{- range .Values.ingress.tls }}
    - hosts:
        {{- range .hosts }}
    {{- end }}
  {{- end }}
  ingressClassName: nginx
  rules:
    - host: {{ .Values.ingress.domainName | quote}}
      http:
        paths:
        - path: {{ .Values.ingress.path }}
          pathType: {{ .Values.ingress.pathType }}
          backend:
            service:
              name: "{{ .Values.appName }}-service"
              port:
                number: {{ .Values.service.port }}
{{- end }}
