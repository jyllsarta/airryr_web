echo "git reset"
git reset --hard
echo "git pull"
git pull
echo "bundle install"
bundle install
echo "kill older server"
PID=`ps ax | grep [a]irryr_web | awk '{ print $1 }'`
kill ${PID}
echo "start server"
bundle exec ruby airryr_web.rb -e production >> airryr_web.log  2>&1 &
echo "deploy done."
