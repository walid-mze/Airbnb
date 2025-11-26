# Kubernetes Deployment Guide - Airbnb Booking Application

## 📋 Prerequisites

- Minikube installed and running
- kubectl configured
- Docker image built: `airbnb-booking-app:latest`

## 🚀 Deployment Steps

### Step 1: Start Minikube

```powershell
# Start Minikube
minikube start

# Enable Ingress addon
minikube addons enable ingress

# Verify Minikube is running
minikube status
```

### Step 2: Load Docker Image into Minikube

```powershell
# Use Minikube's Docker daemon
minikube docker-env | Invoke-Expression

# Rebuild the image in Minikube's Docker
docker build -t airbnb-booking-app:latest .

# Or load existing image
# minikube image load airbnb-booking-app:latest
```

### Step 3: Deploy MySQL Database

```powershell
# Apply MySQL deployment
kubectl apply -f k8s/mysql-deployment.yaml

# Wait for MySQL to be ready
kubectl wait --for=condition=ready pod -l app=mysql --timeout=120s

# Check MySQL pod status
kubectl get pods -l app=mysql
```

### Step 4: Deploy Application

```powershell
# Apply application deployment
kubectl apply -f k8s/deployment.yaml

# Apply service
kubectl apply -f k8s/service.yaml

# Check deployment status
kubectl get deployments
kubectl get pods
kubectl get services
```

### Step 5: Deploy Ingress

```powershell
# Apply ingress
kubectl apply -f k8s/ingress.yaml

# Wait for ingress to get IP
kubectl get ingress airbnb-ingress --watch
```

### Step 6: Configure Local DNS (Windows)

```powershell
# Get Minikube IP
minikube ip

# Add to hosts file (run as Administrator)
# Open: C:\Windows\System32\drivers\etc\hosts
# Add line: <MINIKUBE_IP> airbnb.local
```

Or use PowerShell (as Administrator):

```powershell
$minikubeIP = minikube ip
Add-Content -Path C:\Windows\System32\drivers\etc\hosts -Value "`n$minikubeIP airbnb.local"
```

## 🌐 Access the Application

### Option 1: Via Ingress (recommended)

```
http://airbnb.local/home
```

### Option 2: Via NodePort

```powershell
# Get Minikube IP
$minikubeIP = minikube ip

# Access app
Start-Process "http://${minikubeIP}:30080/home"
```

### Option 3: Via Port Forward

```powershell
# Forward port to localhost
kubectl port-forward service/airbnb-app 8080:8080

# Access app
Start-Process "http://localhost:8080/home"
```

## 🔍 Monitoring & Debugging

### Check Pod Logs

```powershell
# List pods
kubectl get pods

# View app logs
kubectl logs -f <airbnb-app-pod-name>

# View MySQL logs
kubectl logs -f <mysql-pod-name>
```

### Check Pod Status

```powershell
# Describe pod
kubectl describe pod <pod-name>

# Get all resources
kubectl get all
```

### Access Pod Shell

```powershell
# Enter app pod
kubectl exec -it <airbnb-app-pod-name> -- bash

# Enter MySQL pod
kubectl exec -it <mysql-pod-name> -- bash
```

### Check Database

```powershell
# Connect to MySQL
kubectl exec -it <mysql-pod-name> -- mysql -uairbnb -pairbnb123 airbnbdb

# Check tables
kubectl exec -it <mysql-pod-name> -- mysql -uairbnb -pairbnb123 airbnbdb -e "SHOW TABLES;"
```

## 📊 Useful Commands

```powershell
# Scale application
kubectl scale deployment airbnb-app --replicas=3

# Update image
kubectl set image deployment/airbnb-app airbnb-app=airbnb-booking-app:v2

# Restart deployment
kubectl rollout restart deployment airbnb-app

# View deployment history
kubectl rollout history deployment airbnb-app

# Rollback deployment
kubectl rollout undo deployment airbnb-app

# Delete all resources
kubectl delete -f k8s/
```

## 🧹 Cleanup

```powershell
# Delete all resources
kubectl delete -f k8s/ingress.yaml
kubectl delete -f k8s/service.yaml
kubectl delete -f k8s/deployment.yaml
kubectl delete -f k8s/mysql-deployment.yaml

# Or delete all at once
kubectl delete -f k8s/

# Stop Minikube
minikube stop

# Delete Minikube cluster
minikube delete
```

## 🎯 Quick Deploy Script

Create `deploy.ps1`:

```powershell
Write-Host "Starting Minikube..." -ForegroundColor Cyan
minikube start

Write-Host "Enabling Ingress..." -ForegroundColor Cyan
minikube addons enable ingress

Write-Host "Loading Docker image..." -ForegroundColor Cyan
minikube image load airbnb-booking-app:latest

Write-Host "Deploying MySQL..." -ForegroundColor Cyan
kubectl apply -f k8s/mysql-deployment.yaml
kubectl wait --for=condition=ready pod -l app=mysql --timeout=120s

Write-Host "Deploying Application..." -ForegroundColor Cyan
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml

Write-Host "Waiting for pods to be ready..." -ForegroundColor Cyan
kubectl wait --for=condition=ready pod -l app=airbnb-app --timeout=120s

Write-Host "`nDeployment complete!" -ForegroundColor Green
Write-Host "`nAccess application at:" -ForegroundColor Yellow
$minikubeIP = minikube ip
Write-Host "  http://${minikubeIP}:30080/home" -ForegroundColor Cyan
Write-Host "  or configure DNS for: http://airbnb.local/home" -ForegroundColor Cyan

Write-Host "`nUseful commands:" -ForegroundColor Yellow
Write-Host "  kubectl get pods" -ForegroundColor White
Write-Host "  kubectl get services" -ForegroundColor White
Write-Host "  kubectl logs -f <pod-name>" -ForegroundColor White
```

## ✅ Verification Checklist

- [ ] Minikube started successfully
- [ ] Ingress addon enabled
- [ ] Docker image loaded in Minikube
- [ ] MySQL pod running
- [ ] Application pods running (2 replicas)
- [ ] Services created
- [ ] Ingress configured
- [ ] Application accessible via browser
- [ ] Database tables created
- [ ] Can register/login

## 🔧 Troubleshooting

### Pods not starting

```powershell
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### Image pull errors

```powershell
# Make sure image is in Minikube
minikube image ls | findstr airbnb
```

### Ingress not working

```powershell
# Check ingress controller
kubectl get pods -n ingress-nginx

# Restart ingress
minikube addons disable ingress
minikube addons enable ingress
```

### Database connection issues

```powershell
# Check MySQL service
kubectl get svc mysql

# Test connection from app pod
kubectl exec -it <airbnb-app-pod> -- curl mysql:3306
```
