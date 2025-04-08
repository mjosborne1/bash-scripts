export API_URL="https://api.terminologyhub.com"
cat > /tmp/data.txt << EOF
{ "grant_type": "username_password", "username": "mjosborne1@gmail.com", "password": "DpQfBUd=iy$"}
EOF
token=`curl -X POST "$API_URL/auth/token" -d "@/tmp/data.txt" -H "Content-type: application/json" | jq '.access_token' | sed 's/"//g'`
## run tests after this
