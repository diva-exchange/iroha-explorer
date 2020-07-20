#
# Iroha Explorer
#
# Copyright (C) 2020 diva.exchange
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Author/Maintainer: konrad@diva.exchange
#

FROM node:lts-alpine

LABEL author="Konrad Baechler <konrad@diva.exchange>" \
  maintainer="Konrad Baechler <konrad@diva.exchange>" \
  name="diva" \
  description="Distributed value exchange upholding security, reliability and privacy" \
  url="https://diva.exchange"

COPY package.json /home/node/package.json

# Applications
COPY app /home/node/app

# Entrypoint
COPY entrypoint.sh /

ENV NPM_CONFIG_LOGLEVEL warn

RUN rm -R /home/node/app/test \
  && cd /home/node/ \
  && npm install --production \
  && chown -R node:node "/home/node" \
  && chmod +x /entrypoint.sh

VOLUME [ "/home/node/" ]
WORKDIR "/home/node/"
USER "node"

# 3900 explorer app
EXPOSE 3900

ENTRYPOINT ["/entrypoint.sh"]