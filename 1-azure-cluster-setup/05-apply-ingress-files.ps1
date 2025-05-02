# Skript 5: 05-apply-ingress-files.ps1
# Zweck: Wendet die Ingress-Dateien in der richtigen Reihenfolge an

# Pfad zu den Dateien
$ARGOCD_INGRESS_FILE = "D:\git_repos\azure-infra-gitops\1-azure-cluster-setup\resources\argocd-ingress.yaml"
$NGINX_INGRESS_FILE = "D:\git_repos\azure-infra-gitops\1-azure-cluster-setup\resources\nginx-ingress.yaml"

# Schritt 1: Prompt zur Bestätigung, dass die öffentliche IP-Adresse in argocd-ingress.yaml eingetragen wurde
# - Der Benutzer muss mit "y" (Ja) oder "n" (Nein) antworten
Write-Host "Hast du die öffentliche IP-Adresse in die argocd-ingress.yaml eingetragen? (y/n)"
$confirmation = Read-Host

# Prüfe die Eingabe des Benutzers
if ($confirmation -ne "y" -and $confirmation -ne "Y") {
    Write-Host "Bitte trage die öffentliche IP-Adresse in die argocd-ingress.yaml ein und führe das Skript erneut aus."
    exit 1
}

# Schritt 2: Erstellt den Namespace "ingress-nginx", falls er nicht existiert
# - Der Namespace wird benötigt, damit der NGINX Ingress-Controller installiert werden kann
Write-Host "Erstelle Namespace ingress-nginx, falls er nicht existiert..."
kubectl create namespace ingress-nginx --dry-run=client -o yaml | kubectl apply -f -

# Schritt 3: Wendet die nginx-ingress.yaml an
# - Diese Datei installiert den NGINX Ingress-Controller, der für den Zugriff auf ArgoCD benötigt wird
Write-Host "Wende nginx-ingress.yaml an..."
kubectl apply -f $NGINX_INGRESS_FILE

# Schritt 4: Warte, bis die NGINX-Pods bereit sind
# - Wir warten, bis die Pods des NGINX Ingress-Controllers im Status "Running" sind
# - Das dauert normalerweise ein paar Minuten, wir geben maximal 5 Minuten (300 Sekunden) Zeit
Write-Host "Warte, bis die NGINX-Pods bereit sind (max. 5 Minuten)..."
kubectl -n ingress-nginx wait --for=condition=Ready pod -l app.kubernetes.io/component=controller --timeout=300s 2>$null

# Prüfe, ob das Warten erfolgreich war
if ($LASTEXITCODE -ne 0) {
    Write-Host "Fehler: NGINX-Pods sind nicht rechtzeitig bereit geworden. Bitte überprüfe den Status mit 'kubectl -n ingress-nginx get pods'."
    exit 1
}

# Schritt 5: Wendet die argocd-ingress.yaml an
# - Diese Datei erstellt einen Ingress für ArgoCD, der den NGINX Ingress-Controller verwendet
Write-Host "Wende argocd-ingress.yaml an..."
kubectl apply -f $ARGOCD_INGRESS_FILE

# Schritt 6: Prüft, ob der ArgoCD-Ingress erstellt wurde
Write-Host "Prüfe, ob der ArgoCD-Ingress erstellt wurde..."
kubectl -n argocd get ingress

Write-Host "Ingress-Dateien wurden erfolgreich angewendet!"