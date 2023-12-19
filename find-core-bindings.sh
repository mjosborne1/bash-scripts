#!/bin/bash
if [ $# -eq 0 ];  then
    echo "Usage: $0 path-to-aucore-ig-output-dir"
    exit
fi

# Set IG output folder 
ig_output_folder="$1"

if [ ! -d $ig_output_folder ]; then
    echo " $ig_output_folder does not exist"
    exit
fi
savedir=`pwd`
workdir=$ig_output_folder
outdir="$HOME/data/ValueSets"
if [ ! -d $outdir ]; then
    echo "Output folder: $outdir does not exist"
    exit
fi
cd $workdir
echo "Looking in $workdir ..."

# CSV output file
csv_out="${outdir}/bindings.csv" 

# ensure it's a new output file
cat /dev/null >| $csv_out

# Initialize CSV
echo "Resource Title,Resource Version,Element,Binding" > "$csv_out"
files=$(ls -1 StructureDefinition*.json)
# Loop through URLs  
for file in $files
do
    #cat $file | jq '.snapshot.element[] | "\(.id),\(.binding?.valueSet)"'
    echo "$file"
    title=$(cat $file | jq -cr '.title')
    version=$(cat $file | jq -cr '.version')
    elements=$(cat $file | jq '.snapshot.element[] | "\(.id),\(.binding?.valueSet)"')   
    for ele in $elements
    do 
       echo "$title,$version,$ele" >> "$csv_out"
    done
done

echo "Bindings output written to $csv_out"
cd $savedir
