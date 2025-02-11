# Dockerfile

# base image
FROM node:lts-alpine3.17

# create & set working directory
WORKDIR /app

#Expose ports
EXPOSE 3000

# copy dependencies files
COPY package.json package-lock.json /app/

# install dependencies
RUN npm install

#Change TimeZone
RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && echo "Asia/Kolkata" > /etc/timezone && apk del tzdata

# Copy source files
COPY . /app

# Build
RUN npm run build

#Change ownership
RUN chown -R node:node /app

#Switch User
USER node

# start app
CMD npm run start
