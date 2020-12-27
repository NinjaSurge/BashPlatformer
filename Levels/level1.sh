source ./Levels/levelMaster.sh
Map=("┃                  <" "┃                  <" "┃              pp  <" "┗━━━━━━━━━━━━━━━━━━━")
Player="@"
level="level1"
ground=${#Map[@]}
WorldBounds=(${#Map[0]} $ground)
playerY=$[ground-1]
clear
setPlayer 2 2
preProcessMap
Game() {
  while true
  do
    # clear
    gravity
    handleInput
    boundries
    renderMap
    setPlayer $playerX $playerY
    printf "\033[$[${WorldBounds[1]}+2];0f"
    read -t 0.1 -n 1 input
  done
}
# echo -e "\033[20;0f${Map[@]}"
Game
