#!/usr/bin/env bash

set -eou pipefail

# FAILS
# Output says "BUILD SUCCESSFUL" but there's no PDF
./src/generate-pdf.sh UBL-Invoice-2.1-Example.xml ubl_invoice
