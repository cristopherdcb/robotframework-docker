FROM fedora:21

MAINTAINER Cristopher Castillo

ENV WORKDIR /home

WORKDIR ${WORKDIR}

# System pre requirements
RUN yum update -y

RUN yum install -y wget \
    sudo \
    tar \
    bzip2 \
    python-pip \
    ssh* \
    openssh-server \
    openssl-devel \
    unzip \
    numpy \
    opencv* \
    tesseract \
    python-devel \
    libffi-devel \
    gcc \    
    xorg-x11-server-Xvfb \
    ratpoison \
    xset \
    firefox \
    yum clean all

# Install selenium chrome driver
RUN wget http://chromedriver.storage.googleapis.com/2.21/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip -d /usr/bin/
RUN rm chromedriver_linux64.zip

# Install Robot Framework and libraries
RUN pip install --upgrade virtualenv
RUN pip install robotframework robotframework-selenium2library robotframework-sshlibrary robotframework-appiumlibrary robotframework-faker

# Install Selenium
RUN pip install -U selenium

# Install maven
RUN wget http://ftp.cixug.es/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar xvf apache-maven-3.3.9-bin.tar.gz -C /usr/local/
RUN rm apache-maven-3.3.9-bin.tar.gz

# Install Oracle Java JDK
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.rpm
RUN rpm -i jdk-8u92-linux-x64.rpm
RUN rm jdk-8u92-linux-x64.rpm

COPY ./docker-resources/ ${WORKDIR}
# Compile and install robot framework sikuli library
RUN /usr/local/apache-maven-3.3.9/bin/mvn clean package
RUN python setup.py install

# Install google chrome
RUN mv ${WORKDIR}/google-chrome.repo /etc/yum.repos.d/
RUN yum install -y google-chrome-stable
RUN rm -rf assembly.xml build lib pom.xml setup.py src target
RUN mkdir robot
RUN chmod 755 execute.sh
