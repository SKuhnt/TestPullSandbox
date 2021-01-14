cmd="sfdx force:org:display --verbose --targetusername $scratch_org_username --json" && (echo $cmd >&2)
output=$($cmd)
echo $output
org_auth_url="$(jq -r '.result.sfdxAuthUrl' <<< $output)"
echo $org_auth_url