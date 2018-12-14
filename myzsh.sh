#!/bin/bash
eth=`nmcli connection show |  head -2 |awk '$1~/eth/{print $1}'`
csip=`ifconfig $eth | head -2 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed -n '1p'`
sip=${csip%.*}.254
rpm -q epel || wget ftp://$sip/epel-release-7-11.noarch.rpm
yum -y install zsh git epel-release
chsh -s /bin/zsh
echo '192.30.253.112 github.com' >> /etc/hosts
while :
do
wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | zsh &
break
done
wait
chmod +x /root/.oh-my-zsh/oh-my-zsh.sh
sleep 1
sed -i "/ZSH_THEME=/d"  /root/.zshrc
sed -i '11a ZSH_THEME="gnzh"' /root/.zshrc
grep 'autojump' /root/.zshrc || echo 'alias rm="\rm -i"
alias cp="\cp -i"
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh' >> /root/.zshrc
chsh -s /bin/zsh
cd /root
yum -y install autojump
cd /root/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
grep 'zsh-syntax-highlighting' ~/.zshrc || echo 'source ~/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
grep 'zshrc'  /etc/rc.d/rc.local || echo '[ -f ~/.zshrc ] && source ~/.zshrc' >> /etc/rc.d/rc.local
source ~/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
wait
sleep 1
/usr/sbin/reboot
