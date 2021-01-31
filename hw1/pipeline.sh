#!/bin/bash
cryptoFile=CryptoDB-50_CparvumIOWA-ATCC.gff

if [ ! -f $cryptoFile ]; then
  wget https://cryptodb.org/common/downloads/Current_Release/CparvumIOWA-ATCC/gff/data/CryptoDB-50_CparvumIOWA-ATCC.gff
fi

nGenes=$(cat CryptoDB-50_CparvumIOWA-ATCC.gff | cut -f3 | grep -v "#" | grep -c "gene")

nCDS=$(cat CryptoDB-50_CparvumIOWA-ATCC.gff | cut -f3 | grep -v "#" | grep -c "CDS")

nExons=$(cat CryptoDB-50_CparvumIOWA-ATCC.gff | cut -f3 | grep -v "#" | grep -c "exon")

ncDnaNames=("tRNA" "rRNA" "five_prime_UTR" "three_prime_UTR" "snRNA")
nNcDna=0

for i in ${!ncDnaNames[@]}
do
  echo "Number of ${ncDnaNames[$i]}: "
  nTmp=$(cat CryptoDB-50_CparvumIOWA-ATCC.gff | cut -f3 | grep -v "#" | grep -c ${ncDnaNames[$i]})
  echo $nTmp
  nNcDna=$((nNcDna+nTmp))
done

echo "Total number of ncDNA: "
echo $nNcDna
