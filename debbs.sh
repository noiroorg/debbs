#!/usr/bin/bash
debbs(){
	printf "\n\033[44m ======     =====     =====        Starting Debbs     =====     =====    =====\033[0m \n\n"  
	printf  "\n\n\033[41m\t Code output : \033[0m\n\n\033[32m"
	if [ $real ]; then
		$1 $2 2>/dev/null
		if [ $4 ]; then
			while [[ $SECONDS -lt 240 ]]; do
				if [[ $2 == *.go ]];then 
					$3 run $2 2>$4
				elif [[ $2  == *.cs ]];then
					cso=$(echo "${2/.cs/}")
					cs=$(echo "${cso}.exe}")
					$3 $2 2>$4
					mono $cs
					if [[ "$save" == "no" ]]; then
						rm $cs
					fi
				elif [[ $2  == *.c ]];then
					c=$(echo "${2/.c/}")
					$3 $2 -o $c  2>$4
					./$c
					if [[ "$save" == "no" ]]; then
						rm $c
					fi
				elif [[ $2  == *.c++ ]];then
					cppo=$(echo "${2/.c++/}")
					cppn=$(echo "${cppo}")
					$3 $2 -o $cppn 2>$4
					./$cppn
					if [[ "$save" == "no" ]]; then
						rm $cppn
					fi
				else
					while [[ $SECONDS -lt 240 ]] ; do
						$3 $2 2>$4
						if [[ $2 == *.java ]]; then
							java $2
						fi 
					done
				fi
				sleep 12
			done
		else
			while [[ $SECONDS -lt 240 ]]; do 
				if [[ $2 == *.go ]];then 
					$3 run $2 
				elif [[ $2  == *.cs ]];then
					cso=$(echo "${2/.cs/}")
					cs=$(echo "${cso}.exe}")
					$3 $2 
					mono $cs
					if [[ "$save" == "no" ]]; then
						rm $cs
					fi
				elif [[ $2  == *.c ]];then
					c=$(echo "${2/.c/}")
					$3 $2 -o $c 
					./$c
					if [[ "$save" == "no" ]]; then
						rm $c
					fi
				elif [[ $2  == *.c++ ]];then
					cppo=$(echo "${2/.c++/}")
					cppn=$(echo "${cppo}")
					$3 $2 -o $cppn 
					./$cppn
					if [[ "$save" == "no" ]]; then
						rm $cppn
					fi
				else
					$3 $2	
					if [[ $2 == *.java ]]; then
						java $2 
					fi
				fi
				sleep 12
			done
		fi
	else
		$1 $2 2>/dev/null
		if [ $4 ]; then 
			if [[ $2 == *.go ]];then 
				$3 run $2 2>$4
			elif [[ $2  == *.cs ]];then
				cso=$(echo "${2/.cs/}")
				cs=$(echo "${cso}.exe}")
				$3 $2 2>$4
				mono $cs
				if [[ $save == "no" ]]; then
					rm $cs
				fi
			elif [[ $2  == *.c ]];then
				c=$(echo "${2/.c/}")
				$3 $2 -o $c  2>$4
				./$c
				if [[ $save == "no" ]]; then
					rm $c
				fi
			elif [[ $2  == *.c++ ]];then
				cppo=$(echo "${2/.c++/}")
				cppn=$(echo "${cppo}")
				$3 $2 -o $cppn 2>$4
				./$cppn
				if [[ $save == "no" ]]; then
					rm $cppn
				fi
			else				
				$3 $2 2>$4
				if [[ $2 == *.java ]]; then
					java $2 
				fi
			fi
		else	
			if [[ $2 == *.go ]];then 
				$3 run $2 
			elif [[ $2  == *.cs ]];then
				cso=$(echo "${2/.cs/}")
				cs=$(echo "${cso}.exe}")
				$3 $2 
				mono $cs
				if [[ $save == "no" ]]; then
					rm $cs
				fi
			elif [[ $2  == *.c ]];then
				c=$(echo "${2/.c/}")
				$3 $2 -o $c 
				./$c
				if [[ $save == "no" ]]; then
					rm $c
				fi
			elif [[ $2  == *.c++ ]];then
				cppo=$(echo "${2/.c++/}")
				cppn=$(echo "${cppo}")
				$3 $2 -o $cppn 
				./$cppn
				if [[ $save == "no" ]]; then
					rm $cppn
				fi
			else
				$3 $2
				if [[ $2 == *.java ]]; then
					java $2 
				fi
			fi
		fi
	fi
	if [ "$save" == "no" ];then 
		printf  "\033[0m\n\n\033[41m Removing file %s\033[0m\n\n" $fileName   
		rm $2  	
		fi
	echo -e "\n\n\033[;44m ======     ======      ======    Closing Debbs    ======      =====    ===== \033[0m\n"
	exit
}
help(){
cat << EOF

		----------------------------- Hey there help menu -----------------------------------------------------------------------------------


                     flag                                usage


                     -f | --fname                      Specify the name of the file to save output with a  |.py | .js | .java | or | .go | extension


                     -h | --help             	       Display help menu
						

                     -u | --usage                      Show   usage menu


                     -s | --save                       Dont save the files . 


                     -e | --editor                     specify  code editor to use


                     -o | --error                      Hides errors. Redirect standard error to a file only see output if code runs without errors.


                     -u | --usage                      See usage examples


		     -r | --real                       See the output while writing code hit ctrl c to quit this mode


		------------------------------------------------------------------------------------------------------------------------------------------
EOF
exit
}
usage(){
cat << EOF

     	------------------------------------------------------ 	Brief usage menu --------------------------------------------------------------

                         use                                                            example


		./mon -f <filename>                                             	./mon -f test.go
	

		./mon -f  <filename>	-r<realmode>					./mon -f test.prg  -r en


		./mon -f <filename> -o <errorToFile>                            	./mon -f test.java -o error.txt


		./mon --help                                		         	for help menu


   		./mon -f <filename> -s <option>                                 	./mon -f test.ktx -s no


		./mon -f <filename> -e <editor>                                 	./mon -f test.js -e code

			
		./mon -f <filename>  -e <editor>  -r <realmode>				./mon -f test.c	  -e atom  -r en


      		./mon -f <filename> -e <editor> -s <save option> -o <errorfile> 	./mon -f test.py -e vim -s no -o /dev/null
			
			
		./mon -f <filename> -e <editor> -s <save option> -o <errorfile> -r <opt> ./mon -f test.py -e vim -s no -o /dev/null -r en
	
	
	-----------------------------------------------------------------------------------------------------------------------------------------

EOF
exit
}
if [ ! $# -eq 0 ]; then
	while getopts ":f:e:o:s:r:u:h:" opt; do
                case $opt in
                f) fileName=$OPTARG;;
                e) edit=$OPTARG;;
                o) errFile=$OPTARG;;
                s) save=$OPTARG;;
		r) rl=$OPTARG;;
		u) usage ;;
		h) help ;;
                esac
	done
else
	echo "   ./debbs  --help 			for help menu "
	exit
fi
if [ ! -e $fileName ];then 
	>$fileName
fi
if [ $edit ];then 
	editor=$edit
else
	editor=nano 
fi
if [[ $rl == "en" ]]; then
	real=$rl
fi
echo $real
if [[ $fileName == *.js ]];then
	comp=node 
elif [[ $fileName == *.py ]];then 
	comp=python 
elif [[ $fileName == *.sh ]];then
	chmod +x $fileName
	comp=bash 
elif [[ $fileName == *.java ]];then 
	comp=javac 
elif [[ $fileName == *.c ]];then 
	comp=gcc
elif [[ $fileName == *.c++ ]];then 
	comp=g++
elif [[ $fileName == *go ]]; then
	comp=go  
elif [[ $fileName == *.kt ]];then 
	comp=kotlinc
elif [[ $fileName == *.prg ]];then 
	comp=perl
elif [[ $fileName == *.cs ]];then 
	comp=mcs
fi
if [ "$fileName" ] && [ "$edit" ] && [ "$errFile" ]; then
	debbs $editor $fileName $comp $errFile 
elif [ "$fileName" ]  && [ "$errFile" ]; then
	debbs $editor $fileName $comp $errFile
elif [ "$fileName" ] && [ "$edit" ]; then
	debbs $editor $fileName $comp 
elif [ "$fileName" ]; then
	debbs $editor $fileName $comp 
fi














































