#!/bin/sh

echo "Welcome to NadekoBot installer"
echo ""

root=$(pwd)
    
base_url="https://gitlab.com/Kwoth/nadeko-bash-installer/-/raw/v4"

script_prereq="n-prereq.sh"
script_install="n-download.sh"
script_run="n-run.sh"

echo ""
echo "Downloading the prerequisites installer script"
rm "$root/$script_prereq" 1>/dev/null 2>&1
wget -N "$base_url/$script_prereq" && bash "$root/$script_prereq"
echo ""

echo ""
echo "Downloading the NadekoBot installer script"
rm "$root/$script_install" 1>/dev/null 2>&1
wget -N "$base_url/$script_install" && bash "$root/$script_install"
echo ""


echo ""
echo "Downloading the NadekoBot run script"
rm "$root/$script_run" 1>/dev/null 2>&1
wget -N "$base_url/$script_run""
echo ""

echo "Finished Downloading and installing Nadeko. Ready to run!"
