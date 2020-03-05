# Install and Configure Linux how I like it on Ubuntu

#=========================================================================

# Install Vim and Configure it & Plugins

mkdir -m ~/.vim/vimrc
mkdir -p ~/.vim/plugged

# Install VimPlug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Configure Key Mappings
cat "inoremap jj <Esc>" >> ~/.vim/vimrc
cat "set number" >> ~/.vim/vimrc

cat << EOF >> ~/.vim/vimrc
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
"call plug#end()
EOF

#=========================================================================

# Standard Tools Apt
apt install curl \
	tree \
	git

# Standard Tools Snap
snap install code \
	go

#############################################################################
# This will set up kubernetes and docker
# s script will set up the node to be a master node.

echo Setting up Kubernetes Node...

swapoff -a && sed -i / swap / s/^/#/ /etc/fstab

# Update instance repos and install standard software.
apt-get update


apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add key for docker-ubuntu repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add repo to end of /etc/apt/source.list
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update new docker repo and install modern docker tools
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

# Update repo list with kubernetes tools and install the 3 universal tools
# all nodes are expected to have.
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl

# You can create a basic image from here if you care to.
# The next portions are specific to the master node.

# Kubeadm prepares master node

kubeadm init

exit

# Make a directory with kubernetes configuration inside HOME.
# Give file super user permissions?
mkdir -p $HOME/.kube
  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  chown $(id -u):$(id -g) $HOME/.kube/config

# Check that what nodes are currently in cluster.
# Then check what pods are available across all namespaces.
kubectl get node
kubectl get pods --all-namespaces

# I have no idea what is going on here.
sysctl net.bridge.bridge-nf-call-iptables=1

# Start clouds.weave.works with kubernetes version passed in
# and also set as an env variable.
exit 
export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
exit

# Check for all nodes once more.
kubectl get nodes

