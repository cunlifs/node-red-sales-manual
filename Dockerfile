FROM cunlifs/ubuntu:v0.5
 
ENV http_proxy http://9.196.156.29:3128
ENV https_proxy http://9.196.156.29:3128

# Db2 client support
RUN npm install ibm_db

# runtime support to enable npm build capabilities
RUN apt-get install -y numactl

# install libibmc++
RUN curl -sL http://public.dhe.ibm.com/software/server/POWER/Linux/xl-compiler/eval/ppc64le/rhel7/ibm-xl-compiler-eval.repo \
        && apt-get install -y install libxlc-16.1.1.3-190404a.ppc64le.rpm

COPY package.json /usr/src/node-red/package.json

RUN python3 -m venv /usr/src/node-red/venv --system-site-packages

#install Watson service nodes and dashdb clinet for Db2
RUN npm install -g --unsafe-perm node-red-nodes-cf-sqldb-dashdb

COPY sales_manual_finder.py /usr/src/node-red/sales_manual_finder.py
COPY sales_manual_product_lifecycle_extractor.py /usr/src/node-red/sales_manual_product_lifecycle_extractor.py
COPY sales-manual-reader-flow.json /usr/src/node-red/sales-manual-reader-flow.json

RUN chmod 750 /usr/src/node-red/sales-manual-reader-flow.json
RUN chown -R node-red:node-red /usr/src/node-red

USER node-red

CMD node-red /usr/src/node-red/sales-manual-reader-flow.json
