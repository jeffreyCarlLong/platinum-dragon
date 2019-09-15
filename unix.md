## Unix Help

FILES="file1
file2
file3"

for f in $FILES ; do somethingToThe/$f ; done

find . -name foo.txt -print


## Unzip all archives in a dir

find . -name '*.zip' -exec sh -c 'unzip -d `dirname {}` {}' ';'


