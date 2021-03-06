#!/usr/bin/bash

#####################
## Get eQTLs.
EQTLeb="/usr/data/GROseq.parser/hg19/gm12878/eqtl/EUR373.gene.cis.FDR5.best.rs137.txt.gz"
EQTLyb="/usr/data/GROseq.parser/hg19/gm12878/eqtl/YRI89.gene.cis.FDR5.best.rs137.txt.gz" ## YRI89, EUR373 
zcat $EQTLyb $EQTLeb | awk 'BEGIN{OFS="\t"} {print "chr"$5,int($7),int($7)+1}' | sort-bed - > eqtl.bed

## eQTL bigWig.
twoBitInfo /gbdb/hg19/hg19.2bit chromInfo.hg19
cat eqtl.bed | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,1}' | uniq > eqtl.bedGraph
bedGraphToBigWig eqtl.bedGraph chromInfo.hg19 eqtl.bw

#####################
## Get TSS ... 
infPos=gm12878.predictions.bedGraph.gz
zcat $infPos | sort-bed - > $infPos.tmp
#zcat $noMapBed | bedmap --echo --count $infPos.tmp - | grep "|0" | sed "s/|0//g" > $infPos.tmp1 # Not mappable at 30bp.
#cat $rnaReps | bedmap --echo --count $infPos.tmp1 - | grep "|0" | sed "s/|0//g" > $infPos.tmp # Remove sites inside of known Pol III repeats.
#rm $infPos.tmp1
cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 0.96) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss.10fdr.bed

cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 1.10) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' >tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss110.bed

cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 1.05) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss105.bed

cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 1) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss100.bed

cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 0.95) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss95.bed

cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 0.90) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss90.bed

cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 0.85) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss85.bed

cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 0.80) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss80.bed

cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 0.75) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss75.bed

cat $infPos.tmp | awk 'BEGIN{OFS="\t"} ($4 > 0.7) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss70.bed

cat $infPos.tmp | grep -v "chrM" | awk 'BEGIN{OFS="\t"} ($4 > 0.65) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss65.bed

cat $infPos.tmp | grep -v "chrM" | awk 'BEGIN{OFS="\t"} ($4 > 0.60) {print $1,$2-151,$3+151,$4}' | sort-bed - |  bedops --merge - | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,"N",0,"+"}' > tmp.mergepred.out
~/bin/tcolapse tmp.mergepred.out 0 500 500 1 | sort-bed - > tmp.mergepred.merge.bed.out ## Not sure why this acts wonky on specificity?!?!
cat tmp.mergepred.merge.bed.out > gm12878.tss60.bed

#####################
## Get DNAse-1.
zcat /usr/data/GROseq.parser/hg19/gm12878/dnase/wgEncodeOpenChromDnaseGm12878Pk.narrowPeak.gz > dnase.narrowpeak.bed

#####################
## Get chromHMM.
zcat /usr/data/GROseq.parser/hg19/gm12878/chromhmm/wgEncodeBroadHmmGm12878HMM.bed.gz | grep "Promoter\|Enhancer" > chromHMM.bed
