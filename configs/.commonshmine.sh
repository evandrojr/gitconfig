while [ -h "$SOURCE" ]; do SOURCE="$(readlink "$SOURCE")"; done
GITROOT="$(builtin cd -P "$(dirname "$SOURCE")" && git root)"
SCRIPTS="$GITROOT/scripts"
CUSTOM_PATHS=$SCRIPTS:~/.rbenv/bin

# Config
source $GITROOT/default/config

# clear custom paths to avoid duplication
PATH=`echo $PATH | sed "s|$CUSTOM_PATHS:||g"`
# add custom paths
export PATH=$CUSTOM_PATHS:$PATH

# RVM
if [[ -x $HOME/.rvm || -x /usr/local/rvm ]] ; then
  if ! (env | grep PATH | grep .rvm > /dev/null); then
    source "/usr/local/rvm/scripts/rvm"
    source "$HOME/.rvm/scripts/rvm"
  fi
fi

# rbenv
if [ `which rbenv` ]; then
  eval "$(rbenv init -)"
fi

case $RUBY_FROM in
rvm)
  DEFAULT_GEMSET=`cat $HOME/.ruby-version`
  rvm use system >/dev/null 2>&1
  [ -n "$DEFAULT_GEMSET" ] && (rvm use $DEFAULT_GEMSET 2>/dev/null)
  ;;
rbenv)
  ;;
esac

# VIM
alias vi='TERM="xterm-256color" vim'
alias vim='TERM="xterm-256color" vim'

# EDITOR
export EDITOR=vim
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# GEM
alias "gem-clear"='for i in `gem list --no-versions`; do gem uninstall -aIx $i; done'
alias be="bundle exec"

# NPM
alias "npm-clear"="sudo npm list -g --depth=0. | grep -v npm | awk -F ' ' '{print $2}' | awk -F '@' '{print $1}'  | sudo xargs npm remove -g"

# Git
alias "g"="git"
alias "git-new-workdir"="/usr/share/doc/git/contrib/workdir/git-new-workdir"
#export GIT_PROXY_COMMAND="proxy"

# android sdk
export ANDROID_HOME=$GITROOT/src/android-sdk-linux
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

