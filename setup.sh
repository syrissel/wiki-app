sudo apt install -y curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get -y update
sudo apt-get -y install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn

cd
wget http://ftp.ruby-lang.org/pub/ruby/2.6/ruby-2.6.5.tar.gz
tar -xzvf ruby-2.6.5.tar.gz
cd ruby-2.6.5/
./configure
make
sudo make install
ruby -v

gem install bundler

gem install rails -v 6.0.3.4

rbenv rehash

sudo apt-get -y install mysql-server mysql-client libmysqlclient-dev
sudo mysql < user-setup.sql
sudo mkdir rails
mv c4smb_doc_app rails/
cd rails
bundle
yarn install
rails db:create
rails db:migrate
rails db:seed
rails s -e production -b 0.0.0.0
