# UBUNTU
# RESIZE IMAGES
rmg(){
  mogrify -resize "$1"x $2
}
rmga(){
  mogrify -resize "$1"x *.jpg
}


alias jall='jpegoptim --strip-all --all-progressive -ptm 80 *.jpg'


alias rndg="rename 's/\d+/sprintf(\"%03d\", $&)/e'"

# CLEAR SPACES BETWEEN THE FILE NAME
alias rnst="rename -v 's/[\ \(\)\&]/-/g' *"


function rn(){
  rename -n s/$1/$2/g *
}
function rv(){
  rename -v s/$1/$2/g *
}

# PREFIX FOR IMAGES 
function rename_images(){
  x=0
  for i in `ls *.jpg`;do mv "$i" $1-$[++x].jpg ;done
}

function rename_prefix(){
 for filename in *.$1; do mv "$filename" "$2${filename}"; done;
}


alias mg='mogrify -format jpg *.png'

# file
function touchFileWithDirs() { 
    mkdir -p  "$1" && touch  "$1"/"$2" 
}

function findFile() { 
    find -name "$1*" -type f 
}

function rmExceptFile(){
  find -maxdepth 1 -type f ! -name "*$1*" -delete
}

function rmFile() { 
  find -name "$1*" -type f -exec rm '{}' \;
}

function cpFilesHere(){
  find . -name "$1" -type f -exec cp "{}" .  \;
}

function cpDirsHere(){
  find . -name "$1" -type d -exec cp "{}" .  \;
}

#dir
function rmDir() { 
  find -name "$1*" -type d -exec rm -rf '{}' \;
}
function findDir() { 
  find -name "$1*" -type d
}

function findEmptyDir(){
  find * -mindepth 1 -type d -empty 
}

function rmEmptyDir(){
  find * -mindepth 1 -type d -empty -delete
}



# WINDOWS

function commit () {
  git add . && git commit -m"$*" && git push
}

function glga(){
  git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s" --date=short -30 --reverse
  # git log $1 -$2 --pretty=oneline --abbrev-commit --reverse | nvim
}

# Yarn
alias ys="yarn start"
alias yd="yarn dev"
alias yb="yarn build"
alias yyd="yarn && yarn dev"
alias yys="yarn && yarn start"
alias y14="nvm use 14"
alias y16="nvm use 16"
alias y14s="nvm use 14 && yarn start"
alias y16d="nvm use 16 && yarn dev"

alias rmnm="rm -rf node_modules"

alias bashrc="code /c/Users/luizl/.bashrc"

alias gtkb="cd /c/Users/luizl/OneDrive/Documentos/BlueLine/Knowledge-base"

alias ll="ls -la"
#Php ==============================
# $1 = template_dir
function mdphp() { 
    mkdir -p  "template-parts/$1"
}
# $1 = template_dir
# $2 = fileName
function touchPhp(){
touch  "template-parts/$1"/"$2.php"
}
#$1 = template_dir
#$2 = fileName
function includeToFrontPage(){
  sed -i -e "0,/get_footer/s#.*get_footer.*#<?php echo get_template_part('template-parts/$1/$2');?>\n&#" front-page.php
}
# $1 = template_dir
# $2 = fileName
function phpLayoutToFile(){
  cat "template-parts/layouts/default.php" > "template-parts/$1"/"$2.php"
}
#$1 = template_dir
#$2 = fileName
function rnphp() { 
    sed -i -e "s/home/$2/g" "template-parts/$1"/"$2.php" 
}
#$1 = template_dir
#$2 = fileName
#$3 = newFileName
function rnGetField() { 
  sed -i -e "s/get_field('$2')/get_field('$3')/" "template-parts/$1"/"$2.php" 
}
#$1 = template_dir
#$2 = fileName
#$3 = newFileName
function rnVariable() { 
  sed -i -e "s/\$$2/\$$3/" "template-parts/$1"/"$2.php" 
}

#$1 = template_dir
#$2 = fileName
#$3 = get_field_name
function rnPhp() { 
  rnGetField $1 $2 $3 && rnVariable $1 $2 $3
}

# $1 = template_dir
# $2 = fileName
# $3 = rename
function wpPhpRename() { 
    mdphp $1 && touchPhp $1 $2 && includeToFrontPage $1 $2 && phpLayoutToFile $1 $2 && rnphp $1 $2 && rnGetField $1 $2 $3 && rnVariable $1 $2 $3
}
# $1 = template_dir
# $2 = fileName
#$3 = get_field_name
#$4 = variable_name
function wpPhp() { 
    mdphp $1 && touchPhp $1 $2 && includeToFrontPage $1 $2 && phpLayoutToFile $1 $2 && rnphp $1 $2
}
# && rnGetField $1 $2 $3 && rnVariable $1 $2 $4
#Scss ==============================
# $1 = template_dir
function mdScss(){
  mkdir -p  "src/scss/blocks/$1"
}
# $1 = template_dir
# $2 = fileName
function touchScss(){
  touch  "src/scss/blocks/$1"/"$2.scss"
}
# $1 = template_dir
# $2 = fileName
function importScss() { 
  echo "@import \"blocks/$1"/"$2\";" >> src/scss/my.scss
}
# $1 = template_dir
# $2 = fileName
function scssLayoutToFile(){
  cat "src/scss/layouts/default.scss" > "src/scss/blocks/$1"/"$2.scss"
}
# $1 = template_dir
# $2 = fileName
function rnscss() { 
    sed -i -e "s/home/$2/g" "src/scss/blocks/$1"/"$2.scss" 
}
# $1 = template_dir
# $2 = fileName
function wpScss() { 
    mdScss $1 && touchScss $1 $2 && importScss $1 $2 && scssLayoutToFile $1 $2 && rnscss $1 $2
}
# $1 = template_dir
# $2 = fileName
# $3 = get_field_name 
# $4 = variable_name
function wpPhpScss(){
  wpPhp $1 $2 && wpScss $1 $2
}

function wpPhpScssRename(){
  wpPhpRename $1 $2 $3 && wpScss $1 $2
}

#Php Component =====================================================================
# $1 = fileName
function touchComponentPhp(){
touch  "components"/"$1.php"
}
# $1 = fileName
function phpComponentLayoutToFile(){
  cat "template-parts/layouts/component.php" > "components"/"$1.php"
}
#$1 = fileName
function rnComponentPhp() { 
    sed -i -e "s/phpComponent/$1/g" "components"/"$1.php" 
}
# $1 = fileName
function wpComponent() { 
    touchComponentPhp $1 && phpComponentLayoutToFile $1 && rnComponentPhp $1
}


#Vue Component =====================================================================
#$1 - dir
function wpVueDir() { 
    mkdir -p "src/vue/components/$1" 
}
# $1 = dir
# $2 = fileName
function touchComponentVue(){
touch  "src/vue/components/$1"/"$2.vue"
}
# $1 = dir
# $2 = fileName
function vueComponentLayoutToFile(){
  cat "template-parts/layouts/default.vue" > "src/vue/components/$1"/"$2.vue"
}
# $1 = dir
# $2 = fileName
# $3 = className
function wpVueRename() { 
    sed -i -e "s/vue/$3/g" "src/vue/components/$1"/"$2.vue" 
}
# $1 = dir
# $2 = fileName
# $3 = className
function wpVueComponent() { 
    wpVueDir $1 touchComponentVue $1 $2 && vueComponentLayoutToFile $1 $2 && wpVueRename $1 $2 $3
}





