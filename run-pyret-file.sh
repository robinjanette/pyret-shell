#!/bin/bash

#Dependencies:

	#This bash script requires Node.js to be installed: https://nodejs.org/en/
	#Once Node.js is successfully installed, clone the Pyret Git repo: https://github.com/brownplt/pyret-lang
	#Follow the instructions in the README under "Installing" to install a local copy of Pyret

#Usage: ./run-pyret.sh relative/path/to/pyret/file/from/Pyret/repo/file.arr

#This bash script expects the input relative path to be from the Pyret repo to the Pyret files, NOT from the location
        #of this script to the Pyret files

#NOTE: Due to an open issue in Pyret, only relative paths can be used for compilation

#Description:
	#This program compiles a specified Pyret .arr file to <file>.jarr in the same directory, then runs the output file
	#The output of the compilation and running can be redirected to a file using &>

PYRETDIR="../pyret-lang/" #PATH TO PYRET REPO, MUST BE CHANGED FROM DEFAULT

#No relative path supplied
if [[ "$#" -lt "1" ]]; then
	echo Usage: ./run-pyret.sh relative/path/to/pyret/file/from/Pyret/repo/file.arr
	exit 0
fi

#Output to stdout
if [[ "$#" -lt "2" ]]; then
        echo -------------------------------------------------
	echo Input file: "$1"
	echo -------------------------------------------------		
		
	#get the output file and input file names
        OUTFILENAME="${1%.*}"
        OUTFILE="$OUTFILENAME.jarr"
        INFILE=$1
	
	cd "$PYRETDIR" || exit
        #compile the input file
	node build/phase0/pyret.jarr \
		--build-runnable "$INFILE" \
		--outfile "$OUTFILE" \
		--builtin-js-dir src/js/trove/ \
		--builtin-arr-dir src/arr/trove \
		--require-config src/scripts/standalone-configA.json

	if [[ -a "$OUTFILE" ]]; then
		#if the standalone .jarr file was created, run that file
		node "$OUTFILE"
	else
		#print that the compilation failed
		echo -------------------------------------------------
		echo Compilation failed for file: "$INFILE"
		echo -------------------------------------------------
	fi
fi
