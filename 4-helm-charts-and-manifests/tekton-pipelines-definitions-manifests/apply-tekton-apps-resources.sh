#!/bin/bash

# Skript zum Anwenden der Tekton-Ressourcen in 4-tekton-pipelines-definitions
# Verwendet relative Pfade, da die Dateien lokal im Verzeichnis liegen

# Schritt 1: Pipeline anwenden
echo "Applying Pipeline..."
kubectl apply -f pipelines/hello-world-microservice-pipeline.yaml

# Schritt 2: Tasks anwenden
echo "Applying Tasks..."
kubectl apply -f tasks/build-and-push-task.yaml
kubectl apply -f tasks/update-deployment-task.yaml

# Schritt 3: Trigger-Ressourcen anwenden
echo "Applying Triggers..."
kubectl apply -f triggers/eventlistener.yaml
kubectl apply -f triggers/github-push-trigger-binding.yaml
kubectl apply -f triggers/pipeline-trigger-template.yaml

echo "All Tekton resources for hello-world pipeline have been applied!"