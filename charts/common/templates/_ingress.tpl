{{- if .Values.ingress.create }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
    name: "{{ .Release.appName }}-ingress"
    namespace: {{ .Values.Namespace }}
    annotations:
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
      cert-manager.io/cluster-issuer: "letsencrypt-prod"
      nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  {{- if .Values.tls }}
  tls:
    {{- range .Values.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
  ingressClassName: nginx
  rules:
    - host: {{ .Values.domainName | quote}}
      http:
        paths:
        - path: {{ .Values.path }}
          pathType: {{ .Values.pathType }}
          backend:
            service:
              name: {{ .Values.serviceName }}
              port:
                number: {{ .Values.servicePort }}
{{- end }}
