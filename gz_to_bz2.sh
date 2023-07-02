#!/bin/bash
#==================================================================================================================================
#title          :gz_to_bz2.sh
#description    :Bash script to convert .gz to .bz2
#author         :Ganesh Chandrasekaran
#date           :2017-06-19
#version        :1.0
#usage          :gz_to_bz2.sh -f filename.gz
#notes          :Dependencies are "bzip2","GNU parallel"
#reference url  :https://medium.com/analytics-vidhya/simple-tutorial-to-install-use-gnu-parallel-79251120d618
#bash_version   :4.1.2(1)-release
#tested on      :CentOS/RHEL/Ubuntu OS
#Version (1.0)  :converting gzip file to bzip file
#==================================================================================================================================
#This set will break the script if variables are not initialized properly.
set -o nounset
#This set will exit the script if any statement returns NON-True (a.k.a false)
set -o errexit

arrParams=( $@ )
iCount=0
iParamCount=$#
iRes=0

function display_help(){
    echo -e "\n\nUsage : sh $0 (parameters given below) \n-f : gzip file. \n -h Help.\n"
    exit 1;    
}

## Checks the number of Command Line Arguments
## If no arguments are passed then displays Usage details and exists.

if [ $iParamCount -eq 0 ]; then
    display_help
fi 

for ((iCount=0;iCount<$#;iCount=iCount+2)); do
    let iRes=iCount+1
    #echo ${arrParams[${iCount}]} " // "  ${arrParams[${iRes}]}
    case ${arrParams[${iCount}]} in
        -h)
            display_help
	    ;;
        -f) zfilename=${arrParams[${iRes}]}
        ;;
     esac
done

if [ -n $zfilename ]; then
    # Retrieves the filename without extension (.gz)
    filenameonly="${zfilename%.*}"
    # Create a .bz2 file
    bzfile="$filenameonly".bz2

    echo "Converting $zfilename to $bzfile ...."
    
    zcat $zfilename | /usr/local/bin/parallel --pipe -k bzip2 --best > $bzfile
    
    echo "Conversion done $bzfile. Removing $zfilename...."
    
    rm $zfilename
fi