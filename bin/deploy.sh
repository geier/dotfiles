#!/bin/sh

# deploying the dotfiles
cd ~/.dotfiles

for file in `find . -name .git -prune -o -name local -prune -o -type f -o -type l -o -print`;
do
	file=${file#./}

	# if dir doesn't exists:
	dir=`dirname $file`
	#echo $dir
	if [ ! -d ~/$dir ]; then
		mkdir -p ~/$dir
	fi
    # add link:
    ln -s ~/.dotfiles/$file ~/$file 2> /dev/null
done

HOST=$(hostname)
if [ -d local/$HOST ]; then
	cd ~/.dotfiles/local/$HOST
	for file in `find . -name .git -prune -o -type f -print`; do
		file=${file#./}
		dir=`dirname $file`
		#echo $dir
		if [ ! -d ~/$dir ]; then
			mkdir -p ~/$dir
		fi
		ln -fs ~/.dotfiles/local/$HOST/$file ~/$file
	done
fi
