## Unix Help

```{bash}
FILES="file1
file2
file3"

for f in $FILES ; do somethingToThe/$f ; done

find . -name foo.txt -print

# Building a file of files

FILE=$(ls dir/*_result.txt| head -1)
head -n 1 $FILE > combined_result.txt
ls dir/*.data.txt > output_files.txt
while IFS= read -r f <&3; 
do
      awk 'FNR==2{print $0 >> "combined_result.txt"}' $f 
done 3< output_files.txt

# Another way to combine certain columns from all files in dir
# For columns 1, 5, 10 af all the text files in the current working directory
awk '{print $1,$5,$10}' *.txt > my.data.txt

# Unzip all archives in a dir
find . -name '*.zip' -exec sh -c 'unzip -d `dirname {}` {}' ';'
```

