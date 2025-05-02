# Skript 3: 03-create-public-ip.ps1
# Zweck: Erstellt eine öffentliche IP-Adresse für den Cluster

# Schritt 1: Erstellt eine öffentliche IP-Adresse in der Knotenressourcengruppe
# - Die Knotenressourcengruppe heißt "MC_playground_playgroundCluster_westeurope"
# - Die IP-Adresse heißt "myAKSPublicIP"
# - Der Typ ist "Standard" (für bessere Leistung und statische IP)
# - Die Zuweisung ist statisch (--allocation-method static), damit sich die IP nicht ändert
# - Die IP-Adresse wird ausgegeben (--query publicIp.ipAddress -o tsv)
Write-Host "Erstelle eine öffentliche IP-Adresse myAKSPublicIP..."
$PUBLIC_IP=$(az network public-ip create `
  --resource-group MC_playground_playgroundCluster_westeurope `
  --name myAKSPublicIP `
  --sku Standard `
  --allocation-method static `
  --query publicIp.ipAddress -o tsv)

# Schritt 2: Zeigt die erstellte öffentliche IP-Adresse an
Write-Host "Die erstellte öffentliche IP-Adresse ist: $PUBLIC_IP"

Write-Host "Öffentliche IP-Adresse wurde erfolgreich erstellt!"
Write-Host "NOTE: Die IP uss in die Windows-Hosts-Datei eingetragen werden, wenn man nicht über die IP gehen will!"