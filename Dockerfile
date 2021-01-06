FROM cunlifs/ubuntu:v0.5
RUN useradd -m -l -d /usr/src/node-red -u 1000730033 -g 0 nodered -p abc1234
COPY sales_manual_finder.py /usr/src/node-red/sales_manual_finder.py
COPY sales_manual_product_lifecycle_extractor.py /usr/src/node-red/sales_manual_product_lifecycle_extractor.py
COPY sales-manual-reader-flow.json /usr/src/node-red/sales-manual-reader-flow.json
COPY package.json /usr/src/node-red/package.json
EXPOSE 1880/tcp
RUN chmod 750 /usr/src/node-red/sales-manual-reader-flow.json
##RUN chown -R node-red:node-red /usr/src/node-red
RUN chmod 777 /usr/src/node-red
ENV http_proxy http://9.196.156.29:3128
ENV https_proxy http://9.196.156.29:3128
RUN python3 -m venv /usr/src/node-red/venv --system-site-packages
#RUN useradd -m -l -d /home/nodered -u 1000730033 -g 0 nodered -p abc1234
USER nodered
WORKDIR /usr/src/node-red
CMD sleep 60000
#CMD node-red /usr/src/node-red/sales-manual-reader-flow.json
