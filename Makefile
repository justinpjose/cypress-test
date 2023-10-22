# https://medium.com/testing-with-cypress/running-cypress-tests-in-docker-containers-using-different-docker-images-2dee3450881e

# Running spec locally
.PHONY: run-local
run-local:
	npx cypress run

# Running spec in a docker container with all browsers
.PHONY: run-docker-all
run-docker-all:
	docker run -it -v ${PWD}:/e2e -w /e2e --name cypress-all cypress/included:12.12.0

# Running spec in a docker container with only chrome
.PHONY: run-docker-chrome
run-docker-chrome:
	docker run -it -v ${PWD}:/e2e -w /e2e --name cypress-chrome cypress/included:12.12.0 -b chrome

# Running the specified spec in docker container
.PHONY: run-docker-spec
run-docker-spec:
	docker run -it -v ${PWD}:/e2e -w /e2e --name cypress-spec cypress/included:12.12.0 -s cypress/e2e/spec.cy.js

# Runs the docker and you get the ability to run `cypress run` inside the container itself as if you do locally
# It gives more control and allows you to run multiple tests in the same container
.PHONY: run-docker-multi
run-docker-multi:
	docker run -it -v ${PWD}:/e2e -w /e2e --name cypress-multi --entrypoint=/bin/bash cypress/included:12.12.0

# Removing stopped (exited) containers in docker
.PHONY: delete-containers
delete-containers:
	docker ps --filter status=exited -q | xargs docker rm