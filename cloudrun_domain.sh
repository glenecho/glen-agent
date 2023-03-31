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


#write cmd line to deploy CloudRun with impersonate account
gcloud beta run deploy $SERVICE_NAME --image $IMAGE --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL

#write cmd line to deploy CloudRun with impersonate account
gcloud beta run deploy $SERVICE_NAME --image $IMAGE --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL --set-env-vars ENV_VAR1=VALUE1,ENV_VAR2=VALUE2

#write cmd line to deploy CloudRun with impersonate account
gcloud beta run deploy $SERVICE_NAME --image $IMAGE --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL --set-env-vars ENV_VAR1=VALUE1,ENV_VAR2=VALUE2 --set-cloudsql-instances $CLOUDSQL_CONNECTION_NAME

#write cmd line to deploy CloudRun with impersonate account
gcloud beta run deploy $SERVICE_NAME --image $IMAGE --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL --set-env-vars ENV_VAR1=VALUE1,ENV_VAR2=VALUE2 --set-cloudsql-instances $CLOUDSQL_CONNECTION_NAME --allow-unauthenticated

#write cmd line to deploy CloudRun with impersonate account
gcloud beta run deploy $SERVICE_NAME --image $IMAGE --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL --set-env-vars ENV_VAR1=VALUE1,ENV_VAR2=VALUE2 --set-cloudsql-instances $CLOUDSQL_CONNECTION_NAME --allow-unauthenticated --vpc-connector $VPC_CONNECTOR

#write cmd line to deploy CloudRun with impersonate account
gcloud beta run deploy $SERVICE_NAME --image $IMAGE --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL --set-env-vars ENV_VAR1=VALUE1,ENV_VAR2=VALUE2 --set-cloudsql-instances $CLOUDSQL_CONNECTION_NAME --allow-unauthenticated --vpc-connector $VPC_CONNECTOR --update-env-vars ENV_VAR1=VALUE1,ENV_VAR2=VALUE2

#write cmd line to configure service account in CloudRun instance
gcloud beta run services add-iam-policy-binding $SERVICE_NAME --member=serviceAccount:$SERVICE_ACCOUNT_EMAIL --role=roles/run.invoker --platform managed --region $REGION --project $PROJECT_ID

#write cmd line to configure service account in CloudRun instance
gcloud beta run services add-iam-policy-binding $SERVICE_NAME --member=serviceAccount:$SERVICE_ACCOUNT_EMAIL --role=roles/run.invoker --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL

#write cmd line to configure service account in CloudRun instance
gcloud beta run services remove-iam-policy-binding $SERVICE_NAME --member=serviceAccount:$SERVICE_ACCOUNT_EMAIL --role=roles/run.invoker --platform managed --region $REGION --project $PROJECT_ID

#write cmd line to configure service account in CloudRun instance
gcloud beta run services remove-iam-policy-binding $SERVICE_NAME --member=serviceAccount:$SERVICE_ACCOUNT_EMAIL --role=roles/run.invoker --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL

#write cmd line to configure service account in CloudRun instance
gcloud beta run services describe $SERVICE_NAME --platform managed --region $REGION --project $PROJECT_ID

#write cmd line to configure service account in CloudRun instance
gcloud beta run services describe $SERVICE_NAME --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL

#write cmd line to configure service account in CloudRun instance
gcloud beta run services list --platform managed --region $REGION --project $PROJECT_ID

#write cmd line to configure service account in CloudRun instance
gcloud beta run services list --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL

#write cmd line to configure service account in CloudRun instance
gcloud beta run services delete $SERVICE_NAME --platform managed --region $REGION --project $PROJECT_ID

#write cmd line to configure service account in CloudRun instance
gcloud beta run services delete $SERVICE_NAME --platform managed --region $REGION --project $PROJECT_ID --impersonate-service-account $SERVICE_ACCOUNT_EMAIL