#!/bin/bash
export THRUNDIR="$HOME/src/term-hub"
cd $THRUNDIR
export API_URL="https://api.terminologyhub.com"
if [[ -z "${token}" ]]; then 
	cat > /tmp/data.txt << EOF
	{ "grant_type": "username_password", "username": "mjosborne1@gmail.com", "password": "DpQfBUd=iy$"}
	EOF
	export token=`curl -X POST "$API_URL/auth/token" -d "@/tmp/data.txt" -H "Content-type: application/json" | jq '.access_token' | sed 's/"//g'`
fi
# run tests
results=$THRUNDIR/test_results.txt
rm -f "$results"
date > "$results"
cd $THRUNDIR/tests
for cmd in test*; do
	if [[ -x "$cmd" ]]; then
		echo "Running $cmd..." >> "$results"
	 	./"$cmd" >> "$results"
	else
		echo "$cmd is not executable or not found"
	fi
done
cd $THRUNDIR
