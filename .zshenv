export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
alias repos='ghq list -p | peco'
alias repo='cd $(repos)'
alias github='gh-open $(repos)'
alias vscode='open -a Visual\ Studio\ Code $PWD'
