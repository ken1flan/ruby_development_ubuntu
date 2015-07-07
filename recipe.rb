[
  "build-essential",
  "git", "bash-completion",
  "mercurial",
  "openssl",
  "luajit", "libluajit-5.1",
  "libperl-dev",
  "libpython-dev",
  "ruby2.1-dev",
  "libruby2.1",
  "libncurses5", "libncurses5-dev",
  "bison",
  "openssl", "libssl-dev",
  "libreadline6",
  "libreadline6-dev",
  "curl",
  "zlib1g", "zlib1g-dev",
  "libyaml-dev",
  "libsqlite3-0", "libsqlite3-dev", "sqlite3",
  "libxml2-dev",
  "libxslt-dev",
  "autoconf",
  "libc6-dev",
  "ncurses-dev",
].each do |package_name|
  package "#{package_name}" do
    action :install
    user "root"
  end
end

execute "install vim" do
  command <<"EOT"
    cd /usr/local/src
    hg clone https://vim.googlecode.com/hg/ vim
    cd vim
    ./configure --with-features=huge \
      --disable-darwin \
      --disable-selinux \
      --enable-multibyte \
      --enable-perlinterp \
      --enable-pythoninterp \
      --enable-rubyinterp \
      --enable-luainterp=dynamic \
      --with-lua-prefix=/usr \
      --with-luajit \
      --enable-fail-if-missing && \
    make && \
    make install
EOT
  user "root"
  not_if "test -e /usr/local/bin/vim"
end

remote_file "/home/vagrant/.vimrc" do
  source "./files/dot.vimrc"
  owner "vagrant"
  group "vagrant"
  user "root"
end

execute "install anyenv" do
  command <<"EOT"
    git clone https://github.com/riywo/anyenv ~/.anyenv
    echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.profile
    echo 'eval "$(anyenv init -)"' >> ~/.profile
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
EOT
  not_if "test -e ~/.anyenv"
end

execute "install rbenv" do
  command <<EOT
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    anyenv install rbenv
EOT
  not_if "test -e ~/.anyenv/envs/rbenv"
end 

execute "install ruby 2.2.2" do
  command <<EOT
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    rbenv install 2.2.2
EOT
  not_if "test -e .anyenv/envs/rbenv/versions/2.2.2"
end 

execute "install ndenv" do
  command <<EOT
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    anyenv install ndenv
EOT
  not_if "test -e ~/.anyenv/envs/ndenv"
end 

execute "install node v0.12.6" do
  command <<EOT
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    ndenv install v0.12.6
EOT
  not_if "test -e .anyenv/envs/ndenv/versions/v0.12.6"
end 
