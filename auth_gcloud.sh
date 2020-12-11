echo $GCLOUD_ACCOUNT_CRED > gcloud.json
gcloud auth activate-service-account 270647425515-it0qf6jth5r14sot1oifartsm52cbe60@developer.gserviceaccount.com --key-file gcloud.json
gcloud config set project triggeredmail
