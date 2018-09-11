#!/bin/bash

#Dependencies:

	#This bash script requires Node.js to be installed: https://nodejs.org/en/
	#Once Node.js is successfully installed, clone the Pyret Git repo: https://github.com/brownplt/pyret-lang
	#Follow the instructions in the README under "Installing" to install a local copy of Pyret

#Usage: ./run-pyret.sh relative/path/to/pyret/files/from/Pyret/repo

#This bash script expects the input relative path to be from the Pyret repo to the Pyret files, NOT from the location
        #of this script to the Pyret files

#NOTE: Due to an open issue in Pyret, only relative paths can be used for compilation

#Description:
	#This program compiles all .arr files in a given directory, then runs those files.
	#The output of the compilation and running can be redirected to a file using &>

PYRETDIR="../pyret-lang/" #PATH TO PYRET REPO, MUST BE CHANGED FROM DEFAULT

#No relative path supplied
if [[ "$#" < "1" ]]; then
	echo Usage: ./run-pyret.sh relative/path/to/pyret/files/from/Pyret/repo
	exit 0
fi

#Output to stdout
if [[ "$#" < "2" ]]; then
	#if compiled directory does not exist, then create it, otherwise continue
	if [[ ! -d "$1/compiled/" ]]; then
		mkdir "$1/compiled/"
	fi
	
	#for each file in the directory
	for i in $( ls $1 ); do
	
		if [[ $i == "compiled" ]]; then
			#don't try to compile the compiled directory
			break
		fi

		echo -------------------------------------------------
		echo Input file: $i
		echo -------------------------------------------------		
		
		#get the output file and input file names
		outfilename="${i%.*}"
		outfile="$1/compiled/$outfilename.jarr"
		infile="$1/$i"
		
		cd $PYRETDIR
		#compile the input file
		node build/phase0/pyret.jarr \
			--build-runnable $infile \
			--outfile $outfile \
			--builtin-js-dir src/js/trove/ \
			--builtin-arr-dir src/arr/trove \
			--require-config src/scripts/standalone-configA.json

		if [[ -a $outfile ]]; then
			#if the standalone .jarr file was created, run that file
			node $outfile
		else
			#print that the compilation failed
			echo -------------------------------------------------
			echo Compilation failed for file: $i
			echo -------------------------------------------------
		fi
		echo
	done
fi