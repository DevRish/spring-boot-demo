To start all required services:

``` 
docker compose up --build -d
```

Next, get into server container and start the server:

```
docker exec -it demo-demo-1 /bin/sh

cd /app

# Optional step if permission geting denied
# chmod 777 buildNrun.sh

./buildNrun.sh
```

After that, write code in the local vs code itself; changes will automatically reflect in container as volume was mounted in docker-compose.
After making necessary changes, again run the `buildNrun.sh` script, and so on...

Note: server could also have been started from dockerfile itself by doing `CMD ["sh","/app/buildNrn.sh"]`, but the issue with
that is the restarting of server after making changes. 
`nodemon` like strategy doesn't suit well with java, as we need to both build and run.
Starting a build after every minor change is not efficient. So rather, get into the container terminal and build and run.

### Lessons while connection to database:

- To expose a docker container port to host, we need to add `ports: 5430:5432` to docker-compose file
  - Note that the proper order is < host-port >:< container-port >
  - So after this, we can access the container's psql process through our local machine's 5430 port. 
    Try it out: `psql -h localhost -p 5430 -U docker`
- To expose all host ports to docker container, we need to add `extra_hosts: host.docker.internal:host-gateway` to docker-compose file
  - So after this, if any process tries to access `host.docker.internal:xxxx` then it would originally be accessing `localhost:xxxx` of the <b>host</b> machine
  - So, I had to add the jdbc address as `jdbc:postgresql://host.docker.internal:5430/student` in application.properties file

So, the docker container of server is accessing `host.docker.internal:5430` which gets redirected to `localhost:5430` of local machine which again gets redirected
to `localhost:5432` of postgres container (due to port exposing done for postgres container); and thus finally its able to access the database.
