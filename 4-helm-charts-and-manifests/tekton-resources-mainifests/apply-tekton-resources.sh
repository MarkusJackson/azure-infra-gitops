#!/bin/bash

# Skript zum Anwenden der Tekton-Ressourcen in der richtigen Reihenfolge
# Verwendet relative Pfade, da die Dateien lokal im Verzeichnis 5-tekton-resources/ liegen

# Schritt 1: ServiceAccount anwenden
echo "Applying ServiceAccount..."
kubectl apply -f tekton-pipelines/service-account.yaml

# Schritt 2: Secret anwenden
echo "Applying Secret..."
kubectl apply -f tekton-pipelines/docker-credentials.yaml

# Schritt 3: Roles anwenden (in allen Namespaces)
echo "Applying Roles..."
kubectl apply -f tekton-pipelines/role.yaml
kubectl apply -f hello-world-namespace/role.yaml
kubectl apply -f kafka-playground-namespace/role.yaml

# Schritt 4: RoleBindings anwenden (in allen Namespaces)
echo "Applying RoleBindings..."
kubectl apply -f tekton-pipelines/role-binding.yaml
kubectl apply -f hello-world-namespace/role-binding.yaml
kubectl apply -f kafka-playground-namespace/role-binding.yaml

echo "All Tekton resources have been applied!"