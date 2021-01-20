project = "braintree-sample-app"

build: 
	docker image build -t $(project) .

dev: build
	docker run -v $(PWD)/source:/app --env-file='.env-vars' --rm -it $(project) /bin/bash

test: build
	docker run -v $(PWD)/source:/app --rm -it $(project) bundle exec rspec spec

