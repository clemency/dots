# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
#source ~/.bash_profile
#
alias screen='screen -U -D -RR'
PS1='[\u@\h \W]\$ '
export PS1
export TERM=dtterm
alias search=grep
alias ls='ls -G -lw '
alias cd='cd '
alias site_lib='/usr/lib/perl5/site_perl/5.8.8/'
alias fcd='source ~/bin/fcd.sh'
alias gosh="rlwrap -b '(){}[],#\";| ' gosh"
# User specific aliases and functions

alias pmver="perl -le '\$m = shift;eval qq(require \$m) or die qq(module \"\$m\" is not installed\\n); print \$m->VERSION'"
alias irb='rlwrap irb --noreadline'
alias cpan-uninstall='perl -MConfig -MExtUtils::Install -e '"'"'($FULLEXT=shift)=~s{-}{/}g;uninstall "$Config{sitearchexp}/auto/$FULLEXT/.packlist",1'"'"

export PERL5LIB=$HOME/local/lib/perl5:$HOME/local/lib/perl5/site_perl
export PATH=$PATH:/usr/bin:/opt/local/bin:/Users/caval/bin:/usr/local/bin/:/opt/local/bin:/Developer/Tools/:~/lib/flex_sdk_2/bin/:/usr/local/mysql/bin:$HOME/local/bin:/usr/local/pgsql/bin
export PERL_AUTOINSTALL=--defaultdeps

alias open=/Applications/CotEditor.app/Contents/MacOS/CotEditor
