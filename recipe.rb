[
  "build-essential",
  "git", "bash-completion",
  "mercurial",
  "luajit", "libluajit-5.1",
  "libperl-dev",
  "libpython-dev",
  "ruby2.1-dev",
  "libruby2.1",
  "libncurses5", "libncurses5-dev"
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
