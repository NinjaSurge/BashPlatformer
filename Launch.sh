clear
bash ./tools/center -n -t "Welcome to BashPlatformer!"
bash ./tools/center -n -t "Press \"s\" to start"
bash ./tools/center -t ""
read -n 1 input

if [ "$input" == "s" ]
then
  clear
  bash ./Levels/level1.sh
  exit
fi
