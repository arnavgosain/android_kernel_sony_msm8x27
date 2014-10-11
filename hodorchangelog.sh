#/bin/bash
cp ~/nolinuxnoparty.github.io/nicki/hodor/changelog.html changelog.html
date=`date +%Y%m%d`
echo "Changelogging Hodor Kernel"

echo "For what release is this changelog being prepared for? (Format: r# | yyyymmdd)"
read release

if [ -z "$days" ]; then
        echo "How many days has it been since last release? (Numeric)"
        read days
fi

changelog=changelog.html

for i in $(seq $days);
do
        export after_date=`date --date="$i days ago" +%m/%d/%Y`
        k=$(expr $i - 1)
        export until_date=`date --date="$k days ago" +%m/%d/%Y`
        echo '>[ ' $release ' ]<' "</br>"  >> $changelog
        echo >> $changelog;
        git log --format="| https://github.com/nolinuxnoparty/android_kernel_sony_msm8x27/commit/%h | %s | %an </br>" --reverse --after=$after_date --until=$until_date >> $changelog
        echo >> $changelog;
done

mv changelog.html ~/nolinuxnoparty.github.io/nicki/hodor/changelog.html
