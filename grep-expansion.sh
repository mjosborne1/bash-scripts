#!/bin/bash
#
#   Script: grep-expansion
#   Description: curl tx server with a VS URL and search for a code
#
if [[ $# != 1 ]]; then
	echo "usage: $0 SCTCode"
	exit
fi
echo "Looking for $1"
tx="https://tx.ontoserver.csiro.au/fhir"
tx="https://r4.ontoserver.csiro.au/fhir"
vs_url="$tx/ValueSet/$expand?url=http://snomed.info/sct?fhir_vs=ecl/%5E%2032570581000036105%20&filter=$1"
echo "curl -H "Accept: application/json" $vs_url | grep $1"
#curl $vs_url | grep $1"
curl -H "Accept: application/json" $vs_url | jq 
