#write cmd line to create new CloudRun Domain
gcloud beta run domain-mappings create $DOMAIN --service $SERVICE_NAME --platform managed --region $REGION --project $PROJECT_ID

#write cmd line to create new CloudRun Domain
gcloud beta run domain-mappings describe $DOMAIN --platform managed --region $REGION --project $PROJECT_ID

#write cmd line to create new CloudRun Domain
gcloud beta run domain-mappings list --platform managed --region $REGION --project $PROJECT_ID

#write cmd line to create new CloudRun Domain
gcloud beta run domain-mappings delete $DOMAIN --platform managed --region $REGION --project $PROJECT_ID

#write cmd line to create new CloudRun Domain
gcloud beta run domain-mappings update $DOMAIN --service $SERVICE_NAME --platform managed --region $REGION --project $PROJECT_ID