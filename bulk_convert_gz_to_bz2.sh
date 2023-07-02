#==================================================================================================================================
#!/bin/bash -
#title          :bulk_convert_gz_to_bz2.sh
#description    :Convert gz to bzip
#author         :Ganesh Chandrasekaran
#date           :2018-07-06
#version        :1.0
#usage          :sh bulk_convert_gz_to_bz2.sh
#notes          :Converts all the .gz to .bz2 files.
#dependency     :gz2bz2.sh
#bash_version   :4.1.2(1)-release
#Version (1.0)  :
#==================================================================================================================================

#This set will break the script if variables are not initialized properly.
set -o nounset
#This set will exit the script if any statement returns NON-True (a.k.a false)
set -o errexit

## Mention the path containing .gz files
s_files="/your_folder/*.gz"

for fnpath in $s_files
    do
        if [ -f $fnpath ]; then #Checking whether file exists
            ## Get the file name alone.
            filename="${fnpath##*/}"
            
            #Get the file last modified time as Epoch at second level.
            file_ts=$(stat -c %Z $fnpath)
            #Get the current time as Epoch at second level.
            curr_ts=$(date +%s)

            #Subtract curr_ts - file_ts.. if its less than 5 mins skip the upload as it could be still getting copied.
            #5 mins (300 secs) just to be on safe side with large file.
            diff_ts=`expr $curr_ts - $file_ts`

            if [ $diff_ts -gt 300 ]; then
                sh gz_to_bz2.sh -f $fnpath  >> convert.log
            else
                echo "Skipping $fnpath as timestamp is less than 5 mins." >> update.log 
            fi
        else
            echo "No .gz files to convert." >> convert.log
        fi
    done