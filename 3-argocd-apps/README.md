Diese Files sind Exporte aus Argo-CD (z.B. per GUI, geht aber auch per kubectl) und lassen sich einfach applyen und 
erstellen die ArgoCD Apps....ALLERDINGS werden auf diesem Wege Änderungen in den File selbst (z.B. die ArgoCD-ync-Policy) nicht von AgroCD überwacht. Um das zu erreichen muss man die App selbst in eine 
ArgoCD App als Subapp packen, App-of-App-Prinzip
e.g. kubectl apply -f ./argocd-apps/tekton-pipelines-application.yaml