#!/bin/sh

chromium-browser --no-sandbox --headless --disable-gpu --run-all-compositor-stages-before-draw --print-to-pdf-no-header --print-to-pdf=$2 $1
