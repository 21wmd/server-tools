#!/bin/bash

mkrpm () {

    for i in {1..2721}

    do

        line=$i'p'
        name=$(sed -n "$line" ./etc/rpmlist) 
        mock -r deepin-15-x86_64 $spackages_dir/$name --resultdir=$packages_tmp_dir
        files=$(ls $packages_tmp_dir | grep rpm)
        if [ -z "$files" ]; then
            echo $name >> ./log/rpm-fail
            mkdir ./log/rpm-message/$name
            cp /data/tmp/packages/*.log ./log/rpm-message/$name/
        else
            echo $name >> ./log/successful
            mv $packages_tmp_dir/*.rpm $packages_dir/
        fi
        echo $i >> ./log/history-num
        echo $name >> ./log/history-rpm
        rm $packages_tmp_dir/*

    done

}
