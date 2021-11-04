#!/bin/bash
terraform output $1 | sed 's/"\([^"]*\)"/\1/'
