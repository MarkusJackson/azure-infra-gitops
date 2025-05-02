# Skript 4: 04-install-argocd.ps1
# Zweck: Installiert ArgoCD im Cluster

# Schritt 1: Fügt das Helm-Repository von ArgoCD hinzu
# - Das ist wie eine Adresse, wo Helm die ArgoCD-Software findet
Write-Host "Füge das ArgoCD Helm-Repository hinzu..."
helm repo add argo https://argoproj.github.io/argo-helm

# Schritt 2: Aktualisiert die Liste der verfügbaren Helm-Pakete
# - Das stellt sicher, dass wir die neueste Version von ArgoCD bekommen
Write-Host "Aktualisiere die Helm-Repositories..."
helm repo update

# Schritt 3: Installiert ArgoCD
# - Der Name der Installation ist "argocd"
# - Es wird im Namespace "argocd" installiert (--namespace argocd)
# - Der Namespace wird erstellt, falls er nicht existiert (--create-namespace)
# - Wir verwenden die Version 7.9.0 (--version 7.9.0)
Write-Host "Installiere ArgoCD im Namespace argocd..."
helm install argocd argo/argo-cd --namespace argocd --create-namespace --version 7.9.0

# Schritt 4: Prüft, ob ArgoCD-Pods laufen
# - Wir warten, bis die ArgoCD-Pods im Status "Running" sind
Write-Host "Prüfe, ob ArgoCD-Pods laufen..."
kubectl -n argocd wait --for=condition=Ready pod --all --timeout=300s

Write-Host "ArgoCD wurde erfolgreich installiert!"