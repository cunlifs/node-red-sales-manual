FROM ubuntu
CMD /bin/bash
MAINTAINER Stu Cunliffe,UK s_cunliffe@uk.ibm.com
RUN apt-get update
RUN apt-get install -y npm
RUN apt-get install -y python3
RUN apt-get install -y python3-bs4
RUN apt-get install -y python3-venv
RUN mkdir -p /usr/src/node-red
WORKDIR /usr/src/node-red
RUN groupadd --force node-red
RUN useradd --home /usr/src/node-red --gid node-red node-red
RUN chown -R node-red:node-red /usr/src/node-red
USER node-red
RUN npm install node-red
EXPOSE 1880/tcp
COPY package.json /usr/src/node-red/package.json
COPY sales_manual_finder.py /usr/src/node-red/sales_manual_finder.py
COPY sales_manual_product_lifecycle_extractor.py /usr/src/node-red/sales_manual_product_lifecycle_extractor.py
COPY sales-manual-reader-flow.json /usr/src/node-red/sales-manual-reader-flow.json
RUN chmod 750 /usr/src/node-red/sales-manual-reader-flow.json
RUN HOSTNAME_SHORT='hostname -s'
RUN mv /usr/src/node-red/sales-manual-reader-flow.json /usr/src/node-red/.node-red/flows_$HOSTNAME_SHORT.json
RUN chown node-red:node-red /usr/src/node-red/*
CMD npm start node-red
