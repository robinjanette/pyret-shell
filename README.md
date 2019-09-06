# pyret-shell
This repo contains shell scripts to run Pyret files from the command line


Installation
------------

These scripts require Node.js to be installed: https://nodejs.org/

Once Node.js is successfully installed, clone the Pyret Git repository: https://github.com/brownplt/pyret-lang
Follow the instructions in the Pyret README under "Installing" to make and install a local version of Pyret

Description of Files
--------------------

There are two shell scripts in this repository, run-pyret-file.sh and run-pyret-directory.sh

run-pyret-file.sh expects one argument, the path from the Pyret repository to a Pyret .arr file. This script will compile and run this file and produce a .jarr file of the same name and in the same location as the input file. 

run-pyret-directory.sh expects one argument, the path from the Pyret repository to a directory containing Pyret .arr files. This script will attempt to compile and run every file in the directory and will store the output .jarr files in a new directory within the current directory called compiled.

For both scripts, the input path MUST be relative. There is currently an open issue in the Pyret repository (https://github.com/brownplt/pyret-lang/issues/969) where absolute paths cause failures. 

How to Run
----------

These files contain a variable near the top of the file called PYRETDIR. In order for these scripts to function, you will need to modify this line to be the path from this repository to wherever Pyret was installed. Once that is changed, simply run the desired script with the arguments specified above.
