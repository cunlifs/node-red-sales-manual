FROM cunlifs/ubuntu:v0.5
COPY sales_manual_finder.py /usr/src/node-red/sales_manual_finder.py
COPY sales_manual_product_lifecycle_extractor.py /usr/src/node-red/sales_manual_product_lifecycle_extractor.py
COPY sales-manual-reader-flow.json /usr/src/node-red/sales-manual-reader-flow.json
COPY package.json /usr/src/node-red/package.json
EXPOSE 1880/tcp
RUN chmod 750 /usr/src/node-red/sales-manual-reader-flow.json
RUN chown -R node-red:node-red /usr/src/node-red
ENV http_proxy http://9.196.156.29:3128
ENV https_proxy http://9.196.156.29:3128

RUN mkdir /data
RUN chuser --home-dir /usr/src/node-red -U node-red \
    && chown -R node-red:node-red /data \
    && chown -R node-red:node-red /usr/src/node-red

USER node-red
WORKDIR /usr/src/node-red

# Db2 client support 
RUN npm install ibm_db

#install Watson service nodes and dashdb clinet for Db2
RUN npm install node-red-nodes-cf-sqldb-dashdb
        
# User configuration directory volume instead of ~/.node-red
VOLUME ["/data"]

RUN python3 -m venv /usr/src/node-red/venv --system-site-packages

# Environment variable holding file path for flows configuration
#ENV FLOWS=flows.json
ENV FLOWS=sales-manual-reader-flow.json

CMD ["node", "./node_modules/node-red/red.js", "--userDir", "/data"]

#CMD node-red /usr/src/node-red/sales-manual-reader-flow.json
