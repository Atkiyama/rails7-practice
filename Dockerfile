FROM ruby:3.2.0

# 参考:https://qiita.com/devzooiiooz/items/bd58b1c3178341fa363f
# 環境変数
ENV APP /railsapp
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# 諸々インストール
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt update -qq \
 && apt install -y build-essential mariadb-client nodejs \
 && npm install --global yarn
RUN yarn add @fortawesome/fontawesome-free @fortawesome/fontawesome-svg-core @fortawesome/free-brands-svg-icons @fortawesome/free-regular-svg-icons @fortawesome/free-solid-svg-icons


WORKDIR $APP
COPY Gemfile $APP/Gemfile
COPY Gemfile.lock $APP/Gemfile.lock
RUN bundle install
