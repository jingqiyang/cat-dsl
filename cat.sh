#!/bin/bash
stack clean --full
CAT_FILE=$1 stack build