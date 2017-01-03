# .bash_aliases
# Ver 3.0 20151109 zot u1404
# set up aliases for various machines

# external hosts
alias	tinyprod='ssh -AY tinyprod.net'

alias   terra='ssh -A terra'
alias	rb='ssh -AX rubr'
alias	sv='ssh -AX sv'
alias	zot='ssh -AX zot'
alias	zot-vm='ssh -AX zot-vm'

alias	a='alias'
alias	bye='exit'
alias	d='dirs'
alias	deep='echo $SHLVL shells deep'
alias	dircmp='/usr/5bin/dircmp'
alias	fndwr="gfind . \( -pm 200 -p 200 -o -pm 20 -p 20 -o -pm 2 -p 2 \) ! -name \*.o ! -name \*.a ! -name \*~ ! -name \*.sh ! -type d ! -name \*.cmd ! -name \*strip ! -name \*.symbols"
alias	h='history'
alias	h10='history 10'
alias	h20='history 20'
alias	h30='history 30'
alias	key='shift; ssh-add $@'
alias	ll='ls -lF'
alias	lsf='ls -FC'
alias	p='popd'
alias	pd='pushd'
alias	pd1='pushd +1'
alias	pd2='pushd +2'
alias	pd3='pushd +3'
alias	pd4='pushd +4'
alias   pti='mspdebug tilib gdb'
#alias   p22='mspdebug uif -qjd /dev/ttyUSB0 -v2200 gdb'
#alias   p18='mspdebug uif -qjd /dev/ttyUSB0 -v1800 gdb'
alias   pz1='mspdebug uif -qjd /dev/ttyUSB0 --force-reset gdb'

#alias   proxy='LD_LIBRARY_PATH=/usr/local/lib/libmsp430 mspdebug tilib -q gdb'
#alias     pz1='LD_LIBRARY_PATH=/usr/local/lib/libmsp430 mspdebug tilib -q --force-reset gdb'

#alias   proxy='mspdebug uif -qd /dev/ttyUSB0 gdb'
alias   proxy='mspdebug uif -qjd /dev/ttyUSB0 gdb'

alias	psall='ps -gaxu'

if [ "z$OSNAME" = "zDarwin" ] ; then
    alias	psh='ps -ajx | grep ssh'
else
    # Linux, ... , what else?
    alias	psh='ps -Af | grep ssh'
fi

alias	psme='ps -gxu'
alias	remove='/bin/rm'
alias	rmacs="emacs -title \"ROOT Emacs @ \$HOSTNAME\"&"
alias	rm='rm -i'
alias	setlen='eval `resize`'
alias	setup='. ~cire/.bash_login'
alias	xd='od -tx1 -A x'
alias	yow='exit'
