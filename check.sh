#!bin/sh
#list=gcloud iam service-accounts list --project=<> --format=json --flatten=email
# list=$(gcloud iam service-accounts list --project=<> --format=json --flatten=email | sed 's/[]"",""[]//g')
# echo $list
gcloud iam service-accounts list --project=<> --format=json --flatten=email | sed 's/[]"",""[]//g' > svc
# echo $list > svc.txt
for email in `cat svc`;
do
    echo $email
    key_date=`gcloud iam service-accounts keys list --iam-account=$email --format=json --format='value(validAfterTime)'`
    key_date1=(`echo $key_date |cut -b-10`)
    #key_date1=$(date -d ${key_date} +"%Y/%m/%d" | cut -b-10)
    echo "key_date" $key_date1
    now=$(date -u +"%Y-%m-%d")
    echo "today:" $now
    #echo "key_age"$(`($now - $key_date) / 86400 `)
    #difference= $(date --date="${now} - ${key_date1}" +"%Y-%m-%d")
    difference=$((($(date -u -d $now +%s) - $(date -u -d $key_date1 +%s)) / 86400))
    echo $difference

done

