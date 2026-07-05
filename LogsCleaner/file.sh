
# for file in *; do
#     if [ -f "$file" ]; then
#         echo "$file" >> filesOnly 
#     fi
# done

#   while IFS= read -r line ; do 
#     if [[ "$line" == *.log || "$line" == *.err || "$line" == *.out ]]; then 
#     echo "$line" >> logFiles 
#     fi 
#     done < filesOnly


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

