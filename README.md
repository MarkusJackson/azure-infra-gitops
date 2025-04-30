infra-gitops Repository
This repository contains the GitOps configuration for infrastructure components, such as Tekton, including ArgoCD Applications, Helm Charts, and Tekton Pipelines for infrastructure automation.

Repository Structure
infra-gitops/
├── argocd-apps/                              # Typ: Ordner, Zweck: ArgoCD-Applications für Infrastruktur-Komponenten
│   ├── tekton-pipelines-application.yaml     # Typ: Datei, Zweck: ArgoCD-Application für Tekton-Installation
│   └── tekton-resources-application.yaml     # Typ: Datei, Zweck: ArgoCD-Application für Tekton-Ressourcen (Pipelines, Tasks)
├── helm-charts/                              # Typ: Ordner, Zweck: Helm-Charts für Infrastruktur-Komponenten
│   └── tekton-helm-chart/                    # Typ: Ordner, Zweck: Helm-Chart für Tekton
│       ├── Chart.yaml                        # Typ: Datei, Zweck: Metadaten des Tekton-Helm-Charts
│       ├── values.yaml                       # Typ: Datei, Zweck: Standardwerte für Tekton-Installation
│       └── templates/                        # Typ: Ordner, Zweck: Kubernetes-Ressourcen-Templates für Tekton
│           ├── config-defaults-cm.yaml       # Typ: Datei, Zweck: ConfigMap für Tekton-Defaults
│           ├── tekton-pipelines-controller-deploy.yaml # Typ: Datei, Zweck: Deployment für Tekton-Controller
│           └── ...                           # Weitere Templates (z. B. für Webhooks, Services)
└── README.md                                 # Typ: Datei, Zweck: Dokumentation des Repositories

