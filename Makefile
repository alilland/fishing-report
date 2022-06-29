## -----------------------------------------------------------------------------
## DEVELOPMENT ONLY
## -----------------------------------------------------------------------------
rvm:
	/bin/bash -l -c 'rvm use 3.1.2'
install: rvm
	bundle install
run: rvm
	rake run
elasticsearch:
	./bin/elasticsearch-8.2.3/bin/elasticsearch
kibana:
	./bin/kibana-8.2.3/bin/kibana
