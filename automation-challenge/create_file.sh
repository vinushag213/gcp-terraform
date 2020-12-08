#!/bin/bash

for file_name in *.Z01; 
do
	yy=`echo $file_name | awk -F '.' '{print $2}' | cut -c5-6`
	[ -d "./$yy" ] && echo "Directory $yy exists." || mkdir $yy
	mm=`echo $file_name | awk -F '.' '{print $2}' | cut -c3-4`
	[ -d "./$yy/$mm" ] && echo "Directory ./$yy/$mm exists." || mkdir -p ./$yy/$mm
	dd=`echo $file_name | awk -F '.' '{print $2}' | cut -c1-2`
	[ -d "./$yy/$mm/$dd" ] && echo "Directory ./$yy/$mm/$dd exists." || mkdir -p ./$yy/$mm/$dd
	FTC=`echo $file_name |  awk -F '.' '{print $1}' | cut -c1-2`
	[ -d "./$yy/$mm/$dd/$FTC" ] && echo "Directory ./$yy/$mm/$dd/$FTC exists." || mkdir -p ./$yy/$mm/$dd/$FTC
	[ -e "./$yy/$mm/$dd/$FTC/$file_name" ] && echo "File ./$yy/$mm/$dd/$FTC/$file_name exists." || cp $file_name ./$yy/$mm/$dd/$FTC
done
