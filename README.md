Cloud Foundry Ruby Example application
===============

This is a simple Sinatra 'Hello World' web application.


## Instructions

### Deploy to Cloud Foundry
This step requires you to have Cloud Foundry CLI installed. You can download it from: https://github.com/cloudfoundry/cli/blob/master/README.md#installers

Log into your Cloud Foundry
```
$ cf login -a <paas api url. Warning: default is https, specify http:// if necesary> -u <user/email> -p <pass>
```

Push
```
$ cf push cf-example-sinatra
```
Note: it is possible that this application name is already in use. Change it if you get that error.

If you want to change the memory to allocate to this app:
```
$ cf push -m 64m cf-example-sinatra
```

And that is it. Your (probably) first app deployed into a PaaS :)!
