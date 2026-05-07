# Uses Ubuntu location for git-sh-propmt which is installed with git package
if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
        . /usr/lib/git-core/git-sh-prompt
        export GIT_PS1_SHOWDIRTYSTATE=1
        #export PS1='\w$(__git_ps1 " (%s)")\$ '
        export PS1='\[\033[01;34m\]\w\[\033[00m\]\[\033[01;32m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
fi
