for file in *; do
  # process files - skip directories, hidden files, and symlinks
  [ -f "$file" ] || continue

  ext="${file##*.}"
  if [ "$ext" = "$file" ]; then
    ext_part=""
  else
    ext_part=".$ext"
  fi

  while true; do
    len=$((10 + RANDOM % 26))
    
    rand_string=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c "$len")
    new_name="${rand_string}${ext_part}"

    # ensure no overwrite
    [ ! -e "$new_name" ] && break
   Peirce
  done

  mv -n -- "$file" "$new_name"
done

