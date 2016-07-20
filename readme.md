# Robot Framework Docker Image

Is the docker image containing all prerequirements to run robot scripts

### Details about robot

[Robot Framework](http://robotframework.org/). 

### Prerequirements

**Base:**

1. [Python 2.7](https://www.python.org/download/releases/2.7/)
2. [Pip](https://pypi.python.org/pypi/pip)
3. [Robot Framework](http://robotframework.org/)
4. [Selenium2Library](https://github.com/robotframework/Selenium2Library): Web testing library for Robot Framework
5. [Chromedriver](https://sites.google.com/a/chromium.org/chromedriver/downloads) 
6. [SSHLibrray](https://github.com/robotframework/SSHLibrary):Test library for SSH and SFTP
7. [Sikuli](http://www.sikulix.com/quickstart.html)
8. [SikuliLibrary](https://github.com/rainmanwy/robotframework-SikuliLibrary): Test library based on image recognition for Robot Framework
9. [Faker library](https://pypi.python.org/pypi/robotframework-faker/): Data generation library


### How to execute using docker

The first thing you need to do is building the image and then run a container based on that image

| Command                                                    | Description                          |
| ---------------------------------------------------------- | ------------------------------------ |
| `sudo docker build -t ${robot-image-name} .`| Build a new robot image |
| `sudo docker run --net host --rm -v ${workspace}:/home/robot -i -t ${robot-image} ./execute.sh ${server} ${path-to-test} ${included-tag-test} ${excluded-tag-test} ${browser} ${browser-2}`| Execute functional test according to the following parameters: ${include-tag-test} execute test with this tag, ${excluded-tag-test} exclude test with this tag, ${server} is the main URL, ${browser} is the browser used to execute the test (chrome or firefox), ${browser-2} is the 2nd browser used during the test and ${path-to-test} is the path to one specific test or suite to be executed|
