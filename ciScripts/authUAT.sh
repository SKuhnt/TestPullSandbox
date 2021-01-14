echo $UAT_AUTH_URL > auth.txt
sfdx force:auth:sfdxurl:store --sfdxurlfile auth.txt --setalias uat
rm auth.txt