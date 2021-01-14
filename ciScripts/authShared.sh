echo $SHARED_AUTH_URL > auth.txt
sfdx force:auth:sfdxurl:store --sfdxurlfile auth.txt --setalias shared
rm auth.txt