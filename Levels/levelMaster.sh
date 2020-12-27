Map=()
level=""
Player="@"

WorldBounds=()

platforms=()

ground=${#Map[@]}

processThis=("p" "_" )


handleInput() {
  if [ "$input" == "q" ]
  then
    clear
    exit
  elif [ "$input" == "r" ]
  then
    bash ./Levels/$level.sh
    exit
  fi
  # Player Movement
  if [ "$input" == "w" ]
  then
    setPlayer $playerX $[playerY-1]
  fi
  if [ "$input" == "a" ]
  then
    setPlayer $[playerX-1] $playerY
  fi
  if [ "$input" == "s" ]
  then
    setPlayer $playerX $[playerY+1]
  fi
  if [ "$input" == "d" ]
  then
    setPlayer $[playerX+1] $playerY
  fi
}

preProcessMap() {
  for ((i=0; i < ${WorldBounds[1]}; i++))
  do
    for ((x=0; x < ${WorldBounds[0]}; x++))
    do
      Col=${Map[$i]:$x:1}
      if [ "$Col" == "p" ]
      then
        platforms+=($[x+1])
        platforms+=($[i+1])
      fi
    done
  done
}

processMap() {
  echo -e "\033[25;0f"
  for ((i=0; i <= ${WorldBounds[1]}; i++))
  do
    process="${Map[$i]}"
    for ((x=0; x <${#processThis[@]}; x++))
    do
      I=$[x-1]
      process="${process//${processThis[I]}/${processThis[I+1]}}"
    done
    Map[$i]="$process"
  done
}

renderMap() {
  processMap
  echo -e "\033[10;0fplayerX: $playerX"
  echo -e "\033[11;0fplayerY: $playerY"
  echo -e "\033[12;0fplatforms: ${platforms[@]}"
  echo -e "\033[$[${playerY}-1];0f${Map[$[playerY-3]]}"
  echo -e "\033[$[${playerY}];0f${Map[$[playerY-2]]}"
  echo -e "\033[$[${playerY}+1];0f${Map[$[playerY-1]]}"
  echo -e "\033[${playerY};${playerX}f$Player"
}

gravity() {
  if [ $playerY -lt $[ground] ] && [ $playerY -ne $ground ]
  then
    playerY=$[playerY+1]
  fi
}

boundries() {
  if [ $playerX -gt $[${WorldBounds[0]}-1] ]; then
    playerX=$[playerX-1]
  elif [[ $playerX -lt 2 ]]; then
    playerX=$[playerX+1]
  elif [[ $playerY -lt 1 ]]; then
    playerY=$[playerY+1]
  elif [[ $playerY -gt $[${WorldBounds[1]-1}] ]]; then
    playerY=$[playerY-1]
  fi
}

# Player
setPlayer() {
  playerX=$1
  playerY=$2
}
