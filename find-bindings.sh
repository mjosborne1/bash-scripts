#!/bin/bash

# Import URL file
url_file="$1"
urls=$(cat "$url_file")

# Set IG output folder 
ig_output_folder="$2"

# CSV output file
csv_out="url_matches.csv" 
# ensure it's a new output file
cat /dev/null >| $csv_out

# Initialize CSV
echo "url,Resource Title,Resource Version" > "$csv_out"

# Loop through URLs  
for url in $urls
do
    # Find matching StructureDefinition files 
    matches=$(grep -l "$url" $ig_output_folder/StructureDefinition*.json)
   
    # Extract filename 
    for match in $matches
    do 
        title=$(cat $match | jq -cr '.title')
        version=$(cat $match | jq -cr '.version')
        
        echo "$url,$title,$version" >> "$csv_out"
    done
done

echo "CSV output written to $csv_out"
