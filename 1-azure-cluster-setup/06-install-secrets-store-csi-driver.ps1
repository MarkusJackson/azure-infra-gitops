# Dieses Skript installiert den Secrets Store CSI Driver und den Azure Key Vault Provider clusterweit.
# Der Secrets Store CSI Driver ermöglicht es, Secrets aus externen Quellen wie Azure Key Vault in Kubernetes einzubinden.
# Der Azure Key Vault Provider ist eine Erweiterung, die speziell für Azure Key Vault funktioniert.
# Dies ist eine clusterweite Installation und nicht anwendungsspezifisch.

# Prüfe, ob Helm installiert ist
if (-not (Get-Command helm -ErrorAction SilentlyContinue)) {
    Write-Error "Helm ist nicht installiert. Bitte installiere Helm, bevor du dieses Skript ausführst."
    exit 1
}

# Füge das Helm-Repository für den Secrets Store CSI Driver hinzu
helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
helm repo update

# Installiere den Secrets Store CSI Driver im Namespace kube-system
helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver -n kube-system

# Installiere den Azure Key Vault Provider
kubectl apply -f https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/deployment/provider-azure-installer.yaml

# Überprüfe, ob die Installation erfolgreich war
Write-Output "Überprüfe, ob der Secrets Store CSI Driver läuft..."
kubectl get pods -n kube-system -l app=secrets-store-csi-driver

# Überprüfe, ob die CRDs installiert wurden
Write-Output "Überprüfe, ob die CRDs installiert wurden..."
kubectl get crd | Select-String secrets-store