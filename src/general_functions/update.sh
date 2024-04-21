#called inside an if block. Run only if a new install.

function update_computer {
# $1 silent

if [[ $(uname) == Darwin ]] ; then
return 0

#Removing the need for Homebrew at the beginning. Users can choose to install it for
#the packages that require it later.
#the code below won't run, and I'll adust it later if needed.
while true ; do
set_terminal
echo -e "
########################################################################################
$cyan
                                 UPDATE THE OS ?
$orange   
    Before using Parmanode, it is strongly recommended that you update your system 
    first. 
    
    This function will update your operating system and add few tools that
    Parmanode uses to function smoothly. 

    One noticable advantage will be a colour text display when using Parmanode, 
    instead of black & white only.

    As it's running, do look at the output, especially near the start; if there is a 
    recommendation to run a command related to \"git unshallow\", then do that.

    WARNING: This can take a really long time. It's ok if you skip now, but do 
    make sure to come back to the \"tools\" menu, and select \"Update Computer\" when 
    you have time.

$green
                       y)      Update
$red
                       n)      Donchu dare ( that means no )
$orange
########################################################################################$yellow
Type$pink y$yellow or$pink n$yellow, then$cyan <enter>$yellow.$orange
"
read choice

case $choice in
y|Y|YES|yes)
if ! which brew >/dev/null ; then install_homebrew ; break
else
brew update
brew upgrade
brew install bash netcat jq vim
break
fi
;;

n|N|NO|no)
break
;;

*) invalid ;;
esac
done
fi # end if mac

if [[ $(uname) == Linux ]] ; then
while true ; do
if [[ $1 != silent ]] ; then
set_terminal
echo -e "
########################################################################################
$cyan
                                 UPDATE THE OS ?
$orange 
    Before using Parmanode, it is strongly recommended that you update your OS first. 
    This function will update your operating system and add few tools that Parmanode 
    uses to function smoothly. 
$green
                       y)      Update
$red
                       n)      Donchu dare (that means no)
$orange
########################################################################################$yellow
Type$pink y$yellow or$pink n$yellow, then$cyan <enter>$yellow.$orange
"
read choice
else
choice=y
fi

case $choice in
y|Y|Yes|yes)
local file="/tmp/update_computer.txt"
sudo apt-get update -y | tee $file
if grep -q "--fix-broken install" < $file ; then
sudo apt-get --fix-broken install -y
fi
if grep -q "--fix-missing install" < $file ; then
sudo apt-get --fix-missing install -y
fi
if grep -q "--fix-missing remove" < $file ; then
sudo apt-get --fix-missing remove -y
fi
if grep -q "--fix-missing upgrade" < $file ; then
sudo apt-get --fix-missing upgrade -y
fi
if grep -q "autoremove" < $file ; then
sudo apt-get autoremove -y
fi
sudo apt-get upgrade -y 
sudo apt-get install jq netcat vim net-tools unzip -y && echo "sudo apt-get install jq netcat vim net-tools unzip -y ; done" >> $dp/.temp 2>&1
install_fuse noupdate #linux minmal installs may need this to run AppImages
break
;;
n|N|NO|No|no)
break
;;
*) invalid ;;
esac
done
fi
}
