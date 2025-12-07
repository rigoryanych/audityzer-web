#!/bin/bash

# AUDITYZER CLOUD RUN DEPLOYMENT SCRIPT
# =======================================
# Run these commands from your local machine with gcloud CLI installed

echo '🚀 AUDITYZER CLOUD RUN DEPLOYMENT SCRIPT'
echo '========================================='

# Step 1: Set project
echo '\n�� Step 1: Setting Google Cloud Project'
gcloud config set project audityzer

# Step 2: Enable APIs
echo '\n🔌 Step 2: Enabling Required Google Cloud APIs'
gcloud services enable run.googleapis.com \\
  cloudbuild.googleapis.com \\
  containerregistry.googleapis.com \\
  --quiet

# Step 3: Build and push API image
echo '\n🔨 Step 3: Building and Pushing API Docker Image'
gcloud builds submit \\
  --tag gcr.io/audityzer/audityzer-web-api:latest \\
  --config cloudbuild.yaml

# Step 4: Deploy API to Cloud Run
echo '\n🚀 Step 4: Deploying API to Cloud Run'
gcloud run deploy audityzer-api \\
  --image gcr.io/audityzer/audityzer-web-api:latest \\
  --platform managed \\
  --region us-central1 \\
  --memory 512Mi \\
  --allow-unauthenticated \\
  --set-env-vars NODE_ENV=production

# Step 5: Deploy Frontend to Cloud Run
echo '\n🚀 Step 5: Deploying Frontend to Cloud Run'
gcloud run deploy audityzer-frontend \\
  --image gcr.io/audityzer/audityzer-web-frontend:latest \\
  --platform managed \\
  --region us-central1 \\
  --memory 256Mi \\
  --allow-unauthenticated \\
  --set-env-vars NEXT_PUBLIC_API_URL=https://audityzer-api-*.a.run.app

# Step 6: Get service URLs
echo '\n🌐 Step 6: Getting Service URLs'
echo 'API URL:'
gcloud run services describe audityzer-api --region us-central1 --format='value(status.url)'
echo '\nFrontend URL:'
gcloud run services describe audityzer-frontend --region us-central1 --format='value(status.url)'

echo '\n✅ Deployment Complete!'
echo '📊 Monitor at: https://console.cloud.google.com/run?project=audityzer'
