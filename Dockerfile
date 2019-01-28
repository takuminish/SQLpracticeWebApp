FROM ubuntu

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile

ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install 2.6.0
RUN rbenv global 2.6.0

RUN /root/.rbenv/shims/ruby -v
RUN /root/.rbenv/shims/gem install bundler

COPY . /app
WORKDIR /app
RUN /root/.rbenv/shims/bundle install