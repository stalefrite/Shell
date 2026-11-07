# Recursively checks working directory + sub-directory(s) for filenames
# which contain space characters. Any spaces are replaced with underscores.

find . -type f -name "* *" -print0 | while IFS= read -r -d '' file; do
    dir=$(dirname "$file")
    
    base=$(basename "$file")
    
    new_base=${base// /_}
    
    mv "$file" "$dir/$new_base"
done
