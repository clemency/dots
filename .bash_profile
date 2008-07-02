#aaaaaaG .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs

export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib/
export LD_LIBRARY_PATH=/usr/local/mysql/lib:$LD_LIBRARY_PATH
export SVN_EDITOR=/usr/bin/vim
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
export PATH=$PATH:/opt/local/bin:/Users/caval/bin:/usr/local/bin/:/opt/local/bin:/Developer/Tools/:~/lib/flex_sdk_2/bin/:/usr/local/mysql/bin:$HOME/local/bin
export MANPATH=/opt/local/share/man:$MANPATH
export PERL5LIB=$HOME/local/lib/perl5:$HOME/local/lib/perl5/site_perl
#export PERL5OPT="-MPerl6::Say"
export SVN_EDITOR=/usr/bin/vim
#export TERM=dtterm
export ACK_OPTIONS="--color --group"
unset USERNAME

