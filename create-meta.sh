#!/bin/bash

set -e
script=$(basename $0)

function usage() {
  echo "$script <C|python>"
}


files=/tmp/files.tmp

lang=$1
case $lang in
  "python")
    ext="py"
    ctags_opts="--python-kinds=-cfmvi -L $files"
    #ctags_opts="-R"
    ;;
  "C")
    ext="[c,h]"
    ctags_opts="--c-kinds=+defglmstuvx -L $files"
    ;;
  *)
    usage
    exit 1
esac

set -u
rm -f tags
rm -f cscope.*
rm -f $files

echo -n "gathering $lang files... "
find -L . -type f -iname "*.$ext" -exec readlink -f {} \; > $files
NUM_files=`wc -l $files`
echo "${NUM_files%% $files} files gathered"

echo -n "building tags... "
ctags $ctags_opts
echo "$PWD/tags created"

echo -n "builing cscope db... "
cscope -bq -i $files
echo "$PWD/cscope.out created"

cwd=$PWD
cd $HOME
echo -n "building gtags db..."
gtags -f $files
mv GPATH GRTAGS GTAGS $cwd
cd $cwd
echo ""
echo "  $cwd/GPATH created"
echo "  $cwd/GRTAGS created"
echo "  $cwd/GTAGS created"

rm $files

