#!/bin/sh
path="$(cd "`dirname "$0"`"/; pwd)"

$path/apacheHttpd.sh
$path/dInstall.sh
