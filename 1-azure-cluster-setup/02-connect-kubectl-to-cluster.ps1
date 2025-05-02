# Skript 2: 02-connect-kubectl-to-cluster.ps1
# Zweck: Verbindet kubectl mit dem neuen AKS-Cluster

# Schritt 1: Aktualisiert die Kubeconfig-Datei, damit kubectl auf den Cluster zugreifen kann
# - Der Cluster heißt "playgroundCluster" und befindet sich in der Ressourcengruppe "playground"
Write-Host "Verbinde kubectl mit dem AKS-Cluster playgroundCluster..."
az aks get-credentials --resource-group playground --name playgroundCluster

# Schritt 2: Prüft, ob kubectl erfolgreich verbunden wurde, indem es die Knoten anzeigt
Write-Host "Prüfe die Verbindung zu kubectl, indem die Knoten angezeigt werden..."
kubectl get nodes

Write-Host "kubectl wurde erfolgreich mit dem Cluster verbunden!"