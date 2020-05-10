<?php

if (getenv('DEBUG') == 'true') {
    $debug = true;
} else {
    $debug = false;
}

$mysqlWriteHost = getenv('MYSQL_HOST');
$mysqlReadHost = getenv('MYSQL_HOST_READONLY');

if ($mysqlReadHost === false) {
    $mysqlReadHost = $mysqlWriteHost;
}

return [
    'debug' => $debug,
    'offline' => false,
    'database' => [
        'write' => [
            'host' => $mysqlWriteHost
        ],
        'read' => [
            'host' => $mysqlReadHost
        ],
        'sticky' => true,
        'driver' => getenv('DB_DRIVER'),
        'database' => getenv('MYSQL_DATABASE'),
        'port' => getenv('MYSQL_PORT'),
        'username' => getenv('MYSQL_USER'),
        'password' => getenv('MYSQL_PASSWORD'),
        'charset' => 'utf8mb4',
        'collation' => 'utf8mb4_unicode_ci',
        'prefix' => 'flarum_',
        'strict' => false,
        'engine' => 'InnoDB',
        'prefix_indexes' => true,
    ],
    'url' => getenv('BASE_URL'),
    'paths' =>
    array(
        'api' => 'api',
        'admin' => 'admin',
    ),
];
