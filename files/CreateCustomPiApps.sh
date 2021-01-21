#! /bin/bash

#NOTE: This file is currently in the works
#Which means DO NOT RUN THIS FILE! It make break pi-apps by Botspot and Pi-AppsTerm by oxmc!

#Variables
workdir="$(HOME)"
todaydate="$(date +"%A,%B,%d,%Y")"
systype="$(cat "${workdir}/data/sysinfo")"

#Functions
function error {
  echo -e "\e[91m$1\e[39m"
  exit 1
}

function getdevicedetails {
  if [ -f $workdir/data/sysinfo ];then
    ARCH=$systype
  else
    ARCH=$(uname -m)
    if [ "${ARCH}" == "armv7l" ]; then
      echo "armhf (32bit)" >> $systype
    elif [ "${ARCH}" == "aarch64" ]; then
      echo "arm64 (64bit)" >> $systype
    fi
  fi
}

#Unused
#
#function createinstallscript {
#  
#}

#Main
#Determine if host is 64 bit or 32 bit
getdevicedetails || error "Unable to detect system type!"
echo "You have a ${ARCH} system."
echo "Do you want terminal, gui, or both versions of pi-apps? t, g, or b"
read a
if [ $a == "t" ];then
  echo "Terminal version selected"
  echo "Installing Pi-AppsTerm..."
  bash $workdir/files/Pi-AppsTerm
if [ $a == "g" ];then
  git clone $Botspot
  bash ~/pi-apps/install
if [ $a == "b" ];then
  echo "Both versions selected"
  echo "Installing..."
  bash $workdir/files/Pi-AppsTerm_install.sh
else
  error "Unkown option '${a}'"
fi

#Unused
#
#echo "Do you only want me to install ${ARCH} type apps? y/n"
#read a
#if [ $a == "n" ];then
#  echo "Ok, Allowing installation of all apps."
#  echo "All" >> $preferedinstalltype
#else
#  echo "Ok, Only allowing installation of ${ARCH}"
#  echo "${ARCH}" >> $preferedinstalltype
#  createinstallscript "$arch"
#fi
