#!/usr/bin/env bash

set -eou pipefail

invoice_name=$1

# ubl_creditnote | ubl_invoice | uncefact
invoice_type=$2

script_dir=$(realpath "$(dirname "$0")")
project_dir=$(dirname "$script_dir")
workdir="$project_dir/tmp"

rm -rf "$workdir"
mkdir "$workdir"

cp "$project_dir/src/build_template.xml" "$workdir/build.xml"
mkdir "$workdir/input"
cp "$project_dir/example_invoices/$invoice_name" "$workdir/input/."


case "$invoice_type" in
    "ubl_creditnote")
    xr_xsl="ubl-creditnote-xr.xsl"
    ;;

    "ubl_invoice")
    xr_xsl="ubl-invoice-xr.xsl"
    ;;
    
    "uncefact")
    xr_xsl="cii-xr.xsl"
    ;;
esac

declare -a expressions=(
    "s|{{basedir}}|$workdir|g"
    "s|{{lib_dir}}|$project_dir/lib|g"
    "s|{{build_dir}}|$project_dir/build|g"
    "s|{{xrechnung_viz_dir}}|$project_dir/xrechnung-visualization|g"
    "s|{{xr_xsl}}|$xr_xsl|g"
)

for expression in "${expressions[@]}" ; do
    sed -i "$expression" "$workdir/build.xml"
done

cd "$workdir" && ant transform-xr-to-pdf