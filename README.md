# Logs-Management
Docker multiple containers logs management into one *.json file

## [Implementation](https://github.com/af4092/Logs-Management/tree/main/docker_logs_test)

1. We first build two `node.js` source files one for `sender.js` which sends message to server and another one is `server.js` server which runs on `port:3001`.
2. Then we make `Dockerfile` for both `sender.js` and `server.js` applications.  

     - `Dockerfile.server` is as following:
       
       ```
        # Use a base image
         FROM node:latest
        # Set the working directory
         WORKDIR /app
        # Copy the server file into the container
         COPY server.js .
        # Expose port 3001
         EXPOSE 3001
        # Run the Node.js server
         CMD ["node", "server.js"]
       ```
       
     - `Dockerfile.sender` is as following:
  
       ```
       # Use a base image
          FROM node:latest
       # Set the working directory
          WORKDIR /app
       # Copy the sender file into the container
          COPY sender.js .
       # Run the message sender
          CMD ["node", "sender.js"]
       ```
3. After making dockerfiles, we build `Docker image` from Dockerfiles with the following commands:

   ```
   $ docker build -t server:v0.1 -f Dockerfile.server .
   $ docker build -t sender:v0.1 -f Dockerfile.sender .
   ```
   <img width="700" alt="image" src="https://github.com/af4092/Logs-Management/assets/24220136/5327a988-4ba0-44fa-81bf-dab47a16cd61">


## [Reference]()

- [Docker](https://docs.docker.com/) - official Docker documentation which shows how to make `image` file and run that particular image inside the `container`.
