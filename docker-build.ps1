# Docker build and deployment script for Airbnb Booking App
# Run this script to build, test, and optionally push to Docker Hub

Write-Host "=== Airbnb Booking App - Docker Build Script ===" -ForegroundColor Cyan

# Step 1: Build the WAR file
Write-Host "`n[1/6] Building WAR file..." -ForegroundColor Yellow
if (-Not (Test-Path "dist\airbnb.war")) {
    Write-Host "WAR file not found. Building application..." -ForegroundColor Yellow
    
    # Compile source
    if (-Not (Test-Path "build\classes")) {
        New-Item -ItemType Directory -Force -Path "build\classes" | Out-Null
    }
    javac -encoding ISO-8859-1 -d build/classes -cp "lib/*" -sourcepath src src/controller/*.java src/dao/*.java src/model/*.java src/function/*.java
    
    # Create distribution
    if (-Not (Test-Path "dist")) {
        New-Item -ItemType Directory -Force -Path "dist" | Out-Null
    }
    xcopy /E /I /Y WebContent dist\Airbnb | Out-Null
    if (-Not (Test-Path "dist\Airbnb\WEB-INF\classes")) {
        New-Item -ItemType Directory -Force -Path "dist\Airbnb\WEB-INF\classes" | Out-Null
    }
    xcopy /E /I /Y build\classes dist\Airbnb\WEB-INF\classes | Out-Null
    xcopy /E /I /Y src\META-INF dist\Airbnb\WEB-INF\classes\META-INF | Out-Null
    
    # Create WAR
    Push-Location dist
    & "C:\Program Files\Java\jdk-17\bin\jar" -cvf airbnb.war -C Airbnb . | Out-Null
    Pop-Location
    
    Write-Host "WAR file created successfully!" -ForegroundColor Green
} else {
    Write-Host "WAR file already exists. Skipping build." -ForegroundColor Green
}

# Step 2: Build Docker image
Write-Host "`n[2/6] Building Docker image..." -ForegroundColor Yellow
$IMAGE_NAME = "airbnb-booking-app"
$VERSION = "1.0"

docker build -t ${IMAGE_NAME}:${VERSION} -t ${IMAGE_NAME}:latest .

if ($LASTEXITCODE -eq 0) {
    Write-Host "Docker image built successfully!" -ForegroundColor Green
} else {
    Write-Host "Docker build failed!" -ForegroundColor Red
    exit 1
}

# Step 3: List created images
Write-Host "`n[3/6] Docker images created:" -ForegroundColor Yellow
docker images | Select-String $IMAGE_NAME

# Step 4: Ask to test locally
Write-Host "`n[4/6] Test locally with Docker Compose?" -ForegroundColor Yellow
$test = Read-Host "Start containers? (y/n)"

if ($test -eq 'y') {
    Write-Host "Starting containers..." -ForegroundColor Yellow
    docker-compose up -d
    
    Write-Host "`nWaiting for services to be ready..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    
    Write-Host "`nContainer status:" -ForegroundColor Yellow
    docker-compose ps
    
    Write-Host "`nApplication available at: http://localhost:8080" -ForegroundColor Green
    Write-Host "To view logs: docker-compose logs -f" -ForegroundColor Cyan
    Write-Host "To stop: docker-compose down" -ForegroundColor Cyan
}

# Step 5: Ask to push to Docker Hub
Write-Host "`n[5/6] Push to Docker Hub?" -ForegroundColor Yellow
$push = Read-Host "Enter your Docker Hub username (or press Enter to skip)"

if ($push) {
    Write-Host "Tagging image for Docker Hub..." -ForegroundColor Yellow
    docker tag ${IMAGE_NAME}:${VERSION} ${push}/${IMAGE_NAME}:${VERSION}
    docker tag ${IMAGE_NAME}:latest ${push}/${IMAGE_NAME}:latest
    
    Write-Host "Logging in to Docker Hub..." -ForegroundColor Yellow
    docker login
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Pushing to Docker Hub..." -ForegroundColor Yellow
        docker push ${push}/${IMAGE_NAME}:${VERSION}
        docker push ${push}/${IMAGE_NAME}:latest
        
        Write-Host "`nImage pushed successfully!" -ForegroundColor Green
        Write-Host "Pull command: docker pull ${push}/${IMAGE_NAME}:latest" -ForegroundColor Cyan
    } else {
        Write-Host "Docker Hub login failed!" -ForegroundColor Red
    }
}

Write-Host "`n[6/6] Done!" -ForegroundColor Green
Write-Host "`n=== Summary ===" -ForegroundColor Cyan
Write-Host "Image: ${IMAGE_NAME}:${VERSION}" -ForegroundColor White
Write-Host "Size: " -NoNewline -ForegroundColor White
docker images ${IMAGE_NAME}:${VERSION} --format "{{.Size}}"
