#!/bin/bash

cd "$(dirname "$0")"

jupyter nbconvert ../analysis.ipynb --to=pdf --template ./template.tplx --output $(dirname "$0")/analysis.pdf
