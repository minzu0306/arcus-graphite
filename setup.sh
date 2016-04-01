#!/bin/bash

. ./env.sh

export LD_LIBRARY_PATH=$COLLECTD_HOME/lib

TEMPLATE_REGEX='s/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/e'
function TEMPLATE
{
  TEMPLATE_TARGET=$1

  # Replace ${ENVIRONMENT_VARIABLE} to actual values.
  # We run the same perl script twice because the regex only works for single ${..} in a line.
  perl -p -i -e "$TEMPLATE_REGEX" < "$TEMPLATE_TARGET.template" > "$TEMPLATE_TARGET.temp"
  perl -p -i -e "$TEMPLATE_REGEX" < "$TEMPLATE_TARGET.temp" > "$TEMPLATE_TARGET"
  rm "$TEMPLATE_TARGET.temp"
}

CONFIG_FILES=(
  collectd/collectd-arcus.conf
  collectd/collectd-arcus-prefix.conf
  conf/conf-orbiter.json
)

# Modify configurations
for file in ${CONFIG_FILES[@]}; do
  echo $file
  TEMPLATE $file
done

# Copy collectd stuffs
mkdir -p $COLLECTD_HOME/plugins/python
cp collectd/arcus_stat.py $COLLECTD_HOME/plugins/python
cp collectd/*.conf $COLLECTD_HOME/etc
cp collectd/types.db $COLLECTD_HOME/share/collectd
