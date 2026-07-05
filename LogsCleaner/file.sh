#this script will put the old/heavey log files inside a special folder called logs so that it 
#gonna clean the folder 

# As you run local apps, build backend servers, or test scripts, log files (*.log , *.err , *.out) and temporary build files pile up and get heavy.

# What it does: Looks inside your local log or temp directories and instantly purges any files that are larger than a specific size (e.g., > 50MB) or older than 7 days, keeping a clean history without bloating your drive.
# if a file with the same name already exists in logs folder , we will use versionin 
#this script doesn't support files in depth more than 1 (it works for the files inside that exact folder not in sub folders)


    find . -maxdepth 1 -type f \
    \( -name "*.log" -o -name "*.out" -o -name "*.err" \) \
    -a \
    \( -size +50M -o -mtime +7 \) > targetedFiles 
     mkdir -p logs # the -p option will make sure not to override the folder if already exists# the -p option will make sure not to override the folder if already exists
   
    while IFS= read -r file ; do
      file="${file#./}" #getting rid of the './' that find cmd adds to refere to the current folder 
      if [[ -e logs/"$file" ]]; then 
      version=1 #the version 1 is the second  
      name="${file%.*}"
      ext="${file##*.}"
      while [[ -e logs/"$name"_"$version"."$ext" ]] ; do 
      version=$((version + 1))
      done 
      mv "$file" logs/"$name"_"$version"."$ext"
      else 
      mv "$file" logs/ 
      fi
      done < targetedFiles
    
    rm targetedFiles

