function alarm()
{
    sleep $1 && mplayer $HOME/alarm.mp3 -loop 0
}

function sum()
{
    awk 'BEGIN {sum=0}
              {sum += $0}
         END {print(sum)}'
}

function avg()
{
    awk 'BEGIN {sum=0; count=0}
              {sum += $0; count += 1}
         END {print(sum/count)}'
}

function is_image_corrupt()
{
    identify -regard-warnings -verbose "$1" > /dev/null 2>&1
    echo $?
}

function is_video_corrupt(){
    ffmpeg -v error -i "$1" -f null -
}

function hexdiff() {
    diff --suppress-common-lines -y <(hexdump -v "$1") <(hexdump -v "$2")
}

function main_branch_name() {
    pull_branch=master
    if [ "$(git branch -ql main | wc -l)" = 1 ]
    then
        pull_branch=main
    fi
    echo $pull_branch
}

function grmpull() {
    # Rebase pull
    git pull origin $(main_branch_name) --rebase --autostash
}

function gmmpull() {
    git pull origin $(main_branch_name) --no-rebase
}

function better_alias {
    type $2 > /dev/null
    if (( $? != 0 ))
    then
        echo "$2 not installed, using default $1"
    else
        alias "$1"="$2"
    fi
}

function rreplace {
    sed -i "s/$1/$2/" $(rg -l "$1")
}

function organize_photos {
    exiftool -d %Y/%m "-directory<datetimeoriginal" *.jpg *.JPG
}

function file_extensions_summary {
    find . -type f | sed -e 's/.*\.//' | sed -e 's/.*\///' | sort | uniq -c | sort -rn
}

function poetry_venv {
    source "$(poetry env list --full-path | head -1 | awk '{print $1}')/bin/activate"
}
