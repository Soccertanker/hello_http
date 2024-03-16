# hello_http
Hello world with a webserver in C


## How to build
```gcc -o dummyserv dummy_serv.c```

Or to build a static binary

```gcc -o dummyserv dummy_serv.c```

## How to run
The port argument is optional and when not included the service will default to port 8080

```dummyserv <port>```

# Docker instructions

## How to build
```docker build -t hello_http .```

## Running the server
```docker run -dp 12344:12344 --name=dummyserv hello_http```

Or, first create the container, then start it:

```docker create -p 12344:12344 --name=dummyserv hello_http```

```docker start dummyserv```

# Terraform instructions

## Build and Deploy
```cd docker```

```terraform init```

```terraform plan```

```terraform apply```

Open localhost:12344 in browser to view the dummy server's response.

## Clean Env
```terraform destroy```

# Packer instructions

```packer init .```

```packer build packer.pkg.hcl```
