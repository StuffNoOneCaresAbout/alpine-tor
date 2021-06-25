FROM alpine:edge

RUN apk add --no-cache \
  tor haproxy ruby privoxy

RUN apk add --no-cache --virtual build-dependencies ruby-bundler ruby-dev  \
  && apk add --no-cache ruby-nokogiri \
  && gem install --no-document socksify \
  && apk del build-dependencies


ADD haproxy.cfg.erb /usr/local/etc/haproxy.cfg.erb
ADD privoxy.cfg.erb /usr/local/etc/privoxy.cfg.erb

ADD start.rb /usr/local/bin/start.rb
RUN chmod +x /usr/local/bin/start.rb

EXPOSE 2090 8118 5566

CMD ruby /usr/local/bin/start.rb
