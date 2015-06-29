title=Running a three node riak cluster using a homebrew installation
date=2012-04-08
type=post
tags=riak, erlang, mac, homebrew, lion
status=published
~~~~~~
If you're following [The Riak Fast Track](http://wiki.basho.com/The-Riak-Fast-Track.html) with a Homebrew-based riak installation, you won't be able to [start up the three nodes as described](http://wiki.basho.com/Building-a-Development-Environment.html#Use-Rebar-to-start-up-three-nodes) without some fiddling, because the Makefile isn't included in the Homebrew installation.

<!--  more -->

If you already [installed Erlang](/blog/2012/04/04/getting-jslint-to-run-on-a-homebrew-based-v8/), the Riak installation is as simple as `brew install riak`.

To create the 4 nodes without the Makefile, you can run the following script. It makes 4 copies of our Homebrew-based Riak installation and adjusts their configuration and the hardcoded path in Riak's executable scripts:

```bash
#!/bin/bash

CWD=$(cd $(dirname $0); pwd)

BASE_DIR="${CWD}/dev"
echo "Creating dev directory ${BASE_DIR}"
mkdir "${BASE_DIR}"

for node in 1 2 3 4; do
  NODE_NAME="dev${node}"
  NODE_DIR="$BASE_DIR/$NODE_NAME"

  echo "Creating node ${NODE_NAME}"
  cp -r $(brew --prefix riak) $NODE_DIR
  
  echo "  Removing data dir"
  rm -rf "$NODE_DIR/libexec/data/"
 
  HTTP="809${node}"
  echo "  Setting 'http' to '${HTTP}'"
  perl -p -i.bak -e 's/({http, \[ {"\d+\.\d+\.\d+\.\d+", )(\d+)( } ]})/${1}'${HTTP}'${3}/g' "$NODE_DIR/libexec/etc/app.config" 
  
  HANDOFF_PORT="810${node}"
  echo "  Setting 'handoff_port' to '${HANDOFF_PORT}'"
  perl -p -i.bak -e 's/({handoff_port, )(\d+)( })/${1}'${HANDOFF_PORT}'${3}/g' "$NODE_DIR/libexec/etc/app.config"
  
  PB_PORT="808${node}"
  echo "  Setting 'pb_port' to '${PB_PORT}'"
  perl -p -i.bak -e 's/({pb_port, )(\d+)( })/${1}'${PB_PORT}'${3}/g' "$NODE_DIR/libexec/etc/app.config"
  
  NAME="dev${node}"
  echo "  Setting 'name' to '${NAME}'"
  perl -p -i.bak -e 's/(-name )(\S+)(@.*)$/${1}'${NAME}'${3}/g' "$NODE_DIR/libexec/etc/vm.args"
  
  NODE_BIN_DIR="$NODE_DIR/libexec/bin"
  echo "  Setting 'RUNNER_SCRIPT_DIR' to '${NODE_BIN_DIR}'"
  perl -p -i.bak -e "s|RUNNER_SCRIPT_DIR=.*$|RUNNER_SCRIPT_DIR=${NODE_BIN_DIR}|g" "$NODE_DIR/bin/riak" \
    "$NODE_DIR/bin/riak-admin" \
    "$NODE_DIR/bin/search-cmd" \
    "$NODE_DIR/libexec/bin/riak" \
    "$NODE_DIR/libexec/bin/riak-admin" \
    "$NODE_DIR/libexec/bin/search-cmd"

done
```

Thanks to [Brian Roach](http://stackoverflow.com/users/302916/brian-roach), who [told me about the hardcoded path inside the executable scripts](http://stackoverflow.com/questions/9906386/running-a-three-node-riak-cluster-using-a-homebrew-installation/9944930#9944930).