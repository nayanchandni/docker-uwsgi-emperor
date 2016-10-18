FROM ubuntu:14.04

# Install required packages and remove the apt packages cache when done.

RUN apt-get update && apt-get install -y \
	git \
	telnet\
        python \
	python-dev \
	python-setuptools \
	sqlite3 \
  && rm -rf /var/lib/apt/lists/*

RUN easy_install pip

# install uwsgi now because it takes a little while
RUN pip install uwsgi

# COPY requirements.txt and RUN pip install BEFORE adding the rest of your code, this will cause Docker's caching mechanism
# to prevent re-installinig (all your) dependencies when you made a change a line or two in your app. 

COPY requirements.txt /usr/src/app/
RUN pip install -r /usr/src/app/requirements.txt

# add (the rest of) our code
COPY . /usr/src/app
