function unmount {
set_terminal
echo " 
Please wait a few seconds for the drive to unmount ... 
"
sleep 2

if [[ $OS == "Linux" ]] ; then

        for i in $( sudo lsblk -nrpo NAME /dev/$disk )
        do 
            sudo umount $i >/dev/null 2>&1 
            log "bitcoin" "for loop i is $i"
            done 
        #redunant but harmless...
        sudo umount /dev/$disk >/dev/null 2>&1 && \
        log "bitcoin" "redundant umount for $disk" && sleep 2 
        return 0
    fi


if [[ $OS == "Mac" ]] ; then

        diskutil unmountDisk $disk 
        log "bitcoin" "unmountDisk for $disk"
        return 0
    fi
}
