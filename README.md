# Cypress-Test

Running Cypress locally and in a docker container

## Prerequisites

<https://medium.com/@gursimratgill/steps-to-install-cypress-16c3d354a9b0>

1. Download node and npm
2. Install Cypress `npm install cypress --save-dev`
3. Run `npx cypress open` to get basic layout for project

## Layout

1. The spec is located in `cypress/e2e`. It is called `spec.cy.js`.

2. There is a `Makefile` which gives you all the commands you need together with shortcuts to run those commands

3. There is this `README` which gives you all the information you need

4. All the remaining files are auto-generated when running `npx cypress open` locally beforehand to generate the basic layout.

5. When you run the commands (the docker ones) below, Cypress will create a video of running the spec which can be found in `cypress/videos`. You won't find it now as the test needs to be run to get it.

## Instructions

These are the available commands that you can use:
    - `make run-local`: Runs the spec locally
    - `make run-docker-all`: Runs the spec in a docker container with all browsers available in the `cypres/included` docker image
    - `make run-docker-chrome`: Runs the spec in a docker container with only chrome
    - `make run-docker-spec`: Runs the specified spec in the docker containter
    - `make run-docker-multi`: Runs the docker and you get the ability to run `cypress run` inside the container itself as if you do locally

### Helper Command

- `make delete-containers`: Removing stopped (exited) containers in docker on your machine

## make run-docker-multi

This process is really powerful. You basically get control of running commands in the docker container itself. When you run `make run-docker-multi`, you will be prompted to enter something.

If you enter `cypress run`, you are essentially running `npx cypress run` in the docker container itself. To exit the container after, you just need to run `exit`.

You are running commands in the container as if you were running them locally.

## Outcome

- The spec should run successfully
- You should see the outcome on your terminal
- A video will be generated at the end which will be stored in `cypress/videos`

## TROUBLESHOOTING

Try these if there are problems:

1. Run `export DOCKER_DEFAULT_PLATFORM=linux/amd64` before running the above commands.

    - This will give a `cypress/included` image with the `amd64` architecture.
    - You would need to remove the current downloaded `cypress/included` docker image from the Docker GUI or using the Docker CLI.
    - I was using this and the image actually included three browsers as well. This might have been the problem.

2. When you get the following error:

    ```bash
    docker: Error response from daemon: Conflict. The container name "/cypress-chrome" is already in use by container "67df68da2c54c5acd6347a27a1161c569378310b66e564f5e79e7c5a1e95318b". You have to remove (or rename) that container to be able to reuse that name.
    ```

    **Run `make delete-containers`**

3. The following is expected. Just give it time and the spec will run:

    ```bash
    DevTools listening on ws://127.0.0.1:41379/devtools/browser/4d66e5b2-6980-4826-a89d-b7bd43d482f2
    libva error: vaGetDriverNameByIndex() failed with unknown libva error, driver_name = (null)
    [408:1022/224757.044447:ERROR:gpu_memory_buffer_support_x11.cc(44)] dri3 extension not supported.
    ```
