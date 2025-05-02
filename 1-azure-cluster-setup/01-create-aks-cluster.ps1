# Skript 1: 01-create-aks-cluster.ps1
# Zweck: Erstellt einen neuen AKS-Cluster in Azure

# Schritt 1: Erstellt einen neuen Kubernetes-Cluster in der Ressourcengruppe "playground"
# - Der Cluster heißt "playgroundCluster"
# - Es wird 1 Worker-Knoten erstellt (--node-count 1)
# - Die VM-Typen sind Skalierungssätze (--vm-set-type VirtualMachineScaleSets)
# - Die Größe der VMs ist Standard_B2s (eine kleine, günstige VM mit 2 CPUs und 4 GB RAM)
# - Netzwerk-Plugin ist "azure" und der Modus ist "overlay" (für bessere Netzwerkleistung)
# - SSH-Schlüssel werden automatisch erstellt (--generate-ssh-keys)
Write-Host "Erstelle AKS-Cluster playgroundCluster in der Ressourcengruppe playground..."
az aks create `
  --resource-group playground `
  --name playgroundCluster `
  --node-count 1 `
  --vm-set-type VirtualMachineScaleSets `
  --node-vm-size Standard_B2s `
  --network-plugin azure `
  --network-plugin-mode overlay `
  --generate-ssh-keys

# Schritt 2: Prüft, ob der Cluster erfolgreich erstellt wurde
Write-Host "Prüfe, ob der Cluster erstellt wurde..."
az aks list --resource-group playground

Write-Host "AKS-Cluster playgroundCluster wurde erstellt!"