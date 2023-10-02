#!/bin/bash

# Export the IDF_PATH
. $IDF_PATH/export.sh

# Build the project
idf.py build

# Start a Bash shell
exec /bin/bash