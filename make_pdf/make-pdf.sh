#!/bin/bash

org_file=$1
sed -e 's/^\*\*\*\*/####/' -e 's/^\*\*\*/###/' -e 's/^\*\*/##/' -e 's/^\*/#/' $org_file  > ./tmp.md
echo $org_file
org_file=${org_file##*/} 
work_file='tmp.md'

#sed -i -E 's/_hznf_/__hznf__/g' tmp.md
#sed -i -E 's/_stopfemicide_/__stopfemicide__/g' tmp.md
#sed -i -E 's/_tmr_tmr_/__tmr__tmr__/g' tmp.md
sed -i -E 's/…/・・・/g' tmp.md
sed -i -E 's/^...＿//g' tmp.md
sed -i -E 's/　\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*//g' tmp.md
sed -i -E "s#https://twitter.com/_hznf_#https://twitter.com/\\\_hznf\\\_#g" tmp.md
sed -i -E "s#https://twitter.com/_stopfemicide_#https://twitter.com/\\\_stopfemicide\\\_#g" tmp.md
sed -i -E "s#https://twitter.com/_tmr_tmr_#https://twitter.com/\\\_tmr\\\_tmr\\\_#g" tmp.md


#sed -i -E '/^>\|.+\|$/,/\|\|<$/s/.+/コード削除/' tmp.md
sed -i -E 's/^>\|.+\|/\\begin{lstlisting}/' tmp.md
sed -i -E 's/\|\|<$/\\end{lstlisting}/' tmp.md

sed -i -E 's/⚡//g' tmp.md

sed -i 's/\\n/￥＼n/g' tmp.md
sed -i -E 's/^(- .+)\[(https?:\/\/.+)\]\(https?:\/\/.+\)$/\1\2/g' tmp.md
sed -i -E 's/(〉〉〉　kk_hironoのリツイート　〉〉〉).*$/\1\n\n/mg' tmp.md
#sed -i -e 's%\(https\?://[^ ]\+\)[ \|"]% <\1>%g' tmp.md
#sed -i -E "s%(https?:\/\/[-_.-p\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+)% <\1>%g" tmp.md



md-to-tex-pandoc.rb tmp.md

day=`ruby -e 'require "wareki";print Date.today.strftime("%Jf")'`
#day="\\\newline ${day/\"//}"
sed -i -E "s/^令和.+\"/$day/" preamble.txt
sed -i -E 's/"(令和.+)\1/' preamble.txt
sed -i -E "/\\maketitle/r preamble.txt" tmp.tex
sed -i -E "/\\makeatother/r preamble_listings.txt" tmp.tex
sed -i -E "1,/\\begin\{document\}/s/(https?:\/\/[-_.-p\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+)/\\\url{\1} /g" tmp.tex
sed -i -E 's/\\\\}/}/' tmp.tex
sed -i -E 's/\\textbackslash\\textgreater\{\}/\\par\\textgreater\{\}/' tmp.tex


lualatex tmp.tex
lualatex tmp.tex
mv tmp.pdf ${org_file/.md/.pdf}
`evince ${org_file/.md/.pdf}`

#rm *.aux *.log *.toc *.tex tmp.txt
