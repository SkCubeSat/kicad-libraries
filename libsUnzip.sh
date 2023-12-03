declare -a ZIP_FILES
ZIP_FILES=(libs/*.zip)
NOT_ZIP_FILES=$(find libs -not -iname "*.zip")

unzipped=out


rm -rf $unzipped
mkdir $unzipped


echo ${ZIP_FILES[@]}

for item in ${ZIP_FILES[@]}
do
	FOLDER=$(basename $item .zip)
	INNER_FOLDER=$(echo $FOLDER | cut -f 2- -d '_')
	KICAD_FOLDER=$INNER_FOLDER/KiCad
	mkdir $unzipped/$FOLDER
	unzip $item -d $unzipped/$FOLDER
	mv -f $unzipped/$FOLDER/$KICAD_FOLDER $unzipped/$INNER_FOLDER
	rm -rf $unzipped/$FOLDER
done

for item in ${NOT_ZIP_FILES[@]} ; do
	if [ $item != "libs" ] ; then
		cp $item $unzipped/
	fi
done

