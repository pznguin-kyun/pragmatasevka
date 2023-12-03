#!/usr/bin/env bash
# Pragmatasevka build script

CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)

patch=private-build-plans.toml

greeting(){
  echo "Welcome to Pragmatasevka build script, $USER!""${BLD}" "${CRE}" "${CNC}"
  echo "Make sure you have installed the following packages in your system: nodejs, npm, ttfautohint, zip." "${BLD}" "${CRE}" "${CNC}"
  sleep 3
}

# Clone Iosevka source code
clone(){
  if [ -d "Iosevka" ]; then
    git -C ./Iosevka pull
  else
    git clone https://github.com/be5invis/Iosevka
  fi
}

make(){
  [ -f ./Iosevka/$patch ] && rm -rf ./Iosevka/$patch
  cp $patch ./Iosevka
  cd Iosevka
  npm install
  npm run build -- contents::pragmatasevka
  cd ..
  zip pragmatasevka-ttf.zip -r ./Iosevka/dist/pragmatasevka/ttf
  zip pragmatasevka-woff2.zip -r ./Iosevka/dist/pragmatasevka/woff2
  rm -rf ./Iosevka/dist
}

done(){
  echo "Pragmatasevka has been built!" "${BLD}" "${CYE}" "${CNC}"
}

greeting
clone
make
done
