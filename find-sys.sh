#!/bin/bash

for f in *.json; do
    jq < "$f" | grep "system"
done

