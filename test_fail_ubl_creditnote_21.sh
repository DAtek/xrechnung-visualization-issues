#!/usr/bin/env bash

set -eou pipefail

# FAILS
# Output says "BUILD SUCCESSFUL" but there's no PDF
./src/generate-pdf.sh UBL-CreditNote-2.1-Example.xml ubl_creditnote
