#Create a scratch org
echo "Creating the Scratch Org..."
cmd="sfdx force:org:create -a circle_build_$CIRCLE_BUILD_NUM --targetdevhubusername devHub --wait 10 orgName=test --definitionfile config/project-scratch-def.json --json" && (echo $cmd >&2)
output=$($cmd) && (echo $output | jq '.' >&2)
echo $output
scratch_org_username="$(jq -r '.result.username' <<< $output)"
echo $scratch_org_username