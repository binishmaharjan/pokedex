#! /bin/bash

# Paths
SCRIPT_DIR=$(cd $(dirname $0); pwd)
APP=$SCRIPT_DIR/../App
RESOURCES=$APP/Pokedex/Resources

### Capitalize the first letter of the word
### Result: hello -> Hello
function capitalize_first_letter() {
	# combine all arguments
	local STRING="$*"
	# variable to store result
	local RESULT=""

	# looping throught each letters
	for (( i=0; i<${#STRING}; i++ )); do

		# storing letter in variable
		local LETTER="${STRING:$i:1}"

		# if first letter convert it to uppercase and append it in the $RESULT, else append in result as it is 
		if [[ i -eq 0 ]]; then
			local UPPERCASE=$LETTER
			RESULT=$(echo $UPPERCASE | tr '[:lower:]' '[:upper:]')
		else
			RESULT=${RESULT}${LETTER}
		fi
	done

	# return the first letter capitalized word
	echo $RESULT 
}

### Lowerise the first letter of the word
### Result: Hello -> hello
function lowerize_first_letter() {
	# combine all arguments
	local STRING="$*"
	# variable to store result
	local RESULT=""

	# looping throught each letters
	for (( i=0; i<${#STRING}; i++ )); do

		# storing letter in variable
		local LETTER="${STRING:$i:1}"

		# if first letter convert it to lowercase and append it in the $RESULT, else append in result as it is 
		if [[ i -eq 0 ]]; then
			local LOWERCASE=$LETTER
			RESULT=$(echo $LOWERCASE | tr '[:upper:]' '[:lower:]')
		else
			RESULT=${RESULT}${LETTER}
		fi
	done

	# return the first letter lowerized word
	echo $RESULT
}

### Convert a string into camel case
### Result: hello_world -> helloWorld
function convert_to_camel_case() {
	# first parameter
	local STRING=$1
	# variable to store result
	local RESULT=""

	#split the word by "_"
	IFS=_ read -ra TEMP <<<"$STRING"

	for (( i=0; i<${#TEMP[@]}; i++ ))
	do
		local CURRENT=$(echo ${TEMP[i]})
		if [[ $i -eq 0 ]]; then
			local LOWERCASE=$(lowerize_first_letter $CURRENT)
			RESULT=${RESULT}${LOWERCASE}
			# RESULT=$CURRENT
		else
			local UPPECASE=$(capitalize_first_letter $CURRENT)
			RESULT=${RESULT}${UPPECASE}
		fi
	done

	echo $RESULT
}

### Generates the contents for Colors.generated.swift file
### Example: /Resources/Colors.xcassets/cFFFFFF@50.colorset
function generate_colors() {

	# Color Resources 
	local COLORS=$RESOURCES/Colors.xcassets
	local COLORS_OUTPUT_FILE=$RESOURCES/Colors.generated.swift

	# get total number of colorset directory, i.e color count
	local COLORS_COUNT=$(find $COLORS/*.colorset -type d | wc -l)

	local COUNT=0
	for entry in $COLORS/*.colorset
	do
		# if index is first write neccesary code
		if [[ $COUNT -eq 0 ]]; then
			printf "import UIKit\n\n" > $COLORS_OUTPUT_FILE
			printf "extension UIColor {\n\n" >> $COLORS_OUTPUT_FILE
		fi

		# split by "/" >> ("Resources", "Colors.xcassets", "cFFFFFF@50.colorset")
		IFS=/ read -ra ARRAY <<<"$entry"

		# ${#ArrayName[@]}: find out length foarray
		# get last element which is colorset directory >> ("cFFFFFF@50.colorset")
		local COLORSET=${ARRAY[${#ARRAY[@]}-1]}

		# split by "." ("cFFFFFF@50", "colorset")
		IFS=. read -ra ARRAY <<<"$COLORSET"

		# get first element which is color name >> ("cFFFFFF@50")
        local ORIRGINAL_COLOR=${ARRAY[0]}

		# Replace special characters with "_" >> ("cFFFFFF_50")
		local EDITED_COLOR=$(echo $ORIRGINAL_COLOR | sed 's/[$&+,:;=?@#|<>.^*()%!-]/_/')

		# define swift color
		printf " \t static let ${EDITED_COLOR} = UIColor(named: \"${ORIRGINAL_COLOR}\")!\n"  >> $COLORS_OUTPUT_FILE

		# if index is last close extension
		if [[ $COUNT -eq $((COLORS_COUNT - 1)) ]]; then
			printf "}" >> $COLORS_OUTPUT_FILE
		fi

		#increment count
		COUNT=$((COUNT+1))
	done
}

### Generates the contents for Images.generated.swift file
### Example: /Resources/Images.xcassets/icon_dummy.imageset
function generate_images() {

	# Image Resources 
	local IMAGES=$RESOURCES/Images.xcassets
	local IMAGES_OUTPUT_FILE=$RESOURCES/Images.generated.swift

	# get total number of imageset directory, i.e image count
	local IMAGES_COUNT=$(find $IMAGES/*.imageset -type d | wc -l)

	local COUNT=0
	for entry in $IMAGES/*.imageset
	do
		# if index is first write neccesary code
		if [[ $COUNT -eq 0 ]]; then
			printf "import UIKit\n\n" > $IMAGES_OUTPUT_FILE
			printf "extension UIImage {\n\n" >> $IMAGES_OUTPUT_FILE
		fi

		# split by "/" >> ("Resources", "Images.xcassets", "icon_dummy.imageset")
		IFS=/ read -ra ARRAY <<<"$entry"

		# get last element which is imageset directory >> ("icon_dummy.imageset"")
		local IMAGESET=${ARRAY[${#ARRAY[@]}-1]}

		# split by "." ("icon_dummy", "imageset")
		IFS=. read -ra ARRAY <<<"$IMAGESET"

		# get first element which is image name, i.e original image name >> ("icon_dummy")
		local ORIGINAL_IMAGE=${ARRAY[0]}

		# replace space and special characters with in image name to "_"
		local EDITED_IMAGE=$(echo $ORIGINAL_IMAGE | sed -e 's/[ ]/_/' -e 's/[$&+,:;=?@#|<>.^*()%!-]/_/')

		# convert to camel case >> ("iconDummy")
		local IMAGE_VAR_NAME=$(convert_to_camel_case $EDITED_IMAGE)

		# define swift color
		printf " \t static let ${IMAGE_VAR_NAME} = UIImage(named: \"${ORIGINAL_IMAGE}\")!\n"  >> $IMAGES_OUTPUT_FILE 

		# if index is last close extension
		if [[ $COUNT -eq $((IMAGES_COUNT - 1)) ]]; then
			printf "}" >> $IMAGES_OUTPUT_FILE
		fi

		#increment count
		COUNT=$((COUNT+1))
	done
}

# generate colors
generate_colors
# generate images
generate_images

