echo "git reset"
git reset --hard
echo "git pull"
git pull
echo "bundle install"
bundle install
echo "kill older server"
PID=`ps ax | grep -e '[a]irryr_web' | awk '{ print $1 }'`
kill ${PID}
echo "start server"
APP_ENV=production bundle exec ruby airryr_web.rb >> airryr_web.log  2>&1 &
echo "deploy done."
