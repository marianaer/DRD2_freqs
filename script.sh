#!/bin/bash

# Guardar lista de poblaciones a usar (modernas)

tail -n+118 rs1076560.ped | cut -d ' ' -f1,2  |awk -v OFS="\t" '$1=$1'> modern_Populations.txt  
paste modern_Populations.txt  <(cut -f1  modern_Populations.txt) > modern_Clusters.dat

# Calcular frecuenciass alelicas
for f in ./*
do	
	
	if [ ${f: -4} == ".ped" ]
	then
		rs=$( basename "$f" .ped )
		plink -file $rs --within modern_Clusters.dat --freq --allow-no-sex --out $rs
		
	fi	
	
done
