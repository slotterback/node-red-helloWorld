# Use the official Node-RED base image
FROM nodered/node-red

USER root

# Copy your local node-red folder into the image
COPY ./flows.json /data/flows.json
COPY ./settings.js /data/settings.js
COPY ./package.json /data/package.json

# Ensure the /data directory has correct permissions for node-red user
RUN chown -R node-red:node-red /data

# Switch back to node-red user
USER node-red

# Install the modules defined in package.json

WORKDIR /usr/src/node-red

# Copy settings into correct place
COPY ./settings.js .node-red/settings.js
COPY ./package.json package.json
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production

# Expose the port for Node-RED
EXPOSE 1880

# Start Node-RED
ENTRYPOINT ["node-red"]