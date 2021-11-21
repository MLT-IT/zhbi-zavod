
echo Найти:
read find
echo -n
echo Заменить на:
read replace

rm -rf $PWD/core/cache/

sed -i "s@$find@$replace@" config.core.php
sed -i "s@$find@$replace@" connectors/config.core.php
sed -i "s@$find@$replace@" manager/config.core.php
sed -i "s@$find@$replace@" core/config/config.inc.php

echo -n