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

     <p align="center">
         <img src="https://github.com/af4092/Logs-Management/assets/24220136/5327a988-4ba0-44fa-81bf-dab47a16cd61.png" alt="Image">
      </p>

4. Then we run the image inside the Docker container with the following commands:

   ```
   $ docker run -d -p 3001:3001 --name server server:v0.1
   $ docker run -d --name sender sender:v0.1
   ```
   
 <p align="center">
         <img src="https://github.com/af4092/Logs-Management/assets/24220136/2eb0fcc3-270e-4b3b-a154-75082ed29842.png" alt="Image">
      </p>

5. We write script file to collect Docker containers logs into one `*.json` file. After running previous images in the Docker containers, we run `collect_logs.sh` script with the following command:

     ```
     $ ./collect_logs.sh
     # then we get following answer from the terminal
     $ Logs collected and saved to logs.json
     ```

6. Then we go inside the `logs.json` file to check the logs output:

<p align="center">
         <img src="https://github.com/af4092/Logs-Management/assets/24220136/5188f2aa-b0d7-4cca-ba22-10ce3c0ba502.png" alt="Image">
      </p>


```diff
- To Do:
- As you've seen currently logs are being gathered only for one container and other container
```


## [Reference]()

- [Docker](https://docs.docker.com/) - official Docker documentation which shows how to make `image` file and run that particular image inside the `container`.
