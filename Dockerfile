FROM cunlifs/ubuntu:v0.2
CMD /bin/bash
MAINTAINER Stu Cunliffe,UK s_cunliffe@uk.ibm.com
RUN mkdir -p /usr/src/node-red
WORKDIR /usr/src/node-red
COPY sales_manual_finder.py /usr/src/node-red/sales_manual_finder.py
COPY sales_manual_product_lifecycle_extractor.py /usr/src/node-red/sales_manual_product_lifecycle_extractor.py
COPY sales-manual-reader-flow.json /usr/src/node-red/sales-manual-reader-flow.json
RUN groupadd --force node-red
RUN useradd --home /usr/src/node-red --gid node-red node-red
RUN chown -R node-red:node-red /usr/src/node-red
RUN npm install -g --unsafe-perm node-red
RUN npm install -g --unsafe-perm node-red-admin
RUN npm install -g --unsafe-perm node-red-contrib-pythonshell
RUN npm install -g --unsafe-perm node-red-node-watson
USER node-red
EXPOSE 1880/tcp
COPY package.json /usr/src/node-red/package.json
RUN python3 -m venv /usr/src/node-red/venv --system-site-packages
RUN chmod 750 /usr/src/node-red/sales-manual-reader-flow.json
#CMD npm start node-red
#Removed npm start and added following
CMD node-red /usr/src/node-red/sales-manual-reader-flow.json
