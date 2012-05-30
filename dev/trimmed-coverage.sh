#!/bin/bash

if test -t 0; then
    echo "Usage:" 1>&2
    echo "\$ bzcat mtcorpus.txt.bz2 | ./$0" 1>&2
    exit 1
fi

# This file is kept even after the script is ended:
needed=/tmp/corpus-stat-all-needed.txt

covgoal="53" # percent goal we aim for this week, according to http://wiki.apertium.org/wiki/Maltese_and_Arabic/Work_plan


cd "$(dirname $0)"

### Prepare tmp files etc.:
g++ apertium-cleanstream.cc -o apertium-cleanstream || exit 1

transfout=$(mktemp -t trimmed-coverage.XXXXXXXXX)
genout=$(mktemp -t trimmed-coverage.XXXXXXXXX)
sorted=$(mktemp -t trimmed-coverage.XXXXXXXXX)

# Make sorting the same regardless of locale:
export LC_ALL='C'

TODOstripwords="the The of oblast in In it if ki any will his this who we right new their kraj that OfNm you www com org Ob http px inst also na on one One On och till und with which were can when was"



### Do the translation:
apertium-deshtml | apertium -f none -d .. kaz-tat-transfer | ./apertium-cleanstream -n | tee "$transfout" | hfst-proc -d ../kaz-tat.autogen.hfst > "$genout"



### Calculate stuff:
numwords=$(grep -cF '^' "$transfout")
numstar=$(grep -cF '^*' "$transfout")
numat=$(grep -cF '^@' "$transfout")
numhash=$(grep -c '^#' "$genout") # Note: this one's a regex, the above are not
numknown=$(calc -p "$numwords - $numstar - $numat - $numhash")
numneeded=$(calc -p "round($numwords * ($covgoal/100) - $numknown)")
echo "Number of tokenised words in the corpus:              $numwords"
echo "Number of tokenised words unknown to analyser:        $numstar"
echo "                                     bidix:           $numat" 
echo "                                     generator:       $numhash"
echo ""
echo "Number of tokenised words passing trimmed testvoc:    $numknown"
echo "giving a trimmed testvoc coverage of                  $(calc -p "round(($numknown)/$numwords*1000)/10") %"
echo ""
echo "Naïve analyser coverage:                              $(calc -p "round(($numwords-$numstar)/$numwords*1000)/10") %"
echo "Bidix coverage (excluding analyser errors):           $(calc -p "round(($numwords-$numat  )/$numwords*1000)/10") %"
echo "Generator coverage (excluding analyser/bidix errors): $(calc -p "round(($numwords-$numhash)/$numwords*1000)/10") %"
echo ""
echo "Top unknown words in the corpus:"
grep -F '^*' "$transfout" | sort -f | uniq -c | sort -gr | tee "$sorted" | head -10
echo ""
echo "Tokens needed to get $covgoal % trimmed coverage:           $numneeded"
echo "Storing corresponding wordlist in $needed"

<"$sorted" awk -vn="$numneeded" '{print $0; t += $1; if( t > n ) exit; } END {print t}' > "$needed"


#tail "$transfout" "$genout" "$sorted" 
rm -f "$transfout" "$genout" "$sorted" 
