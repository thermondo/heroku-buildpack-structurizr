# heroku-buildpack-structurizr
This is a [Heroku buildpack][buildpacks] to run [Structurizr lite][structurizr-lite] within a dyno.

### Setup

```shell
heroku buildpacks:add https://github.com/thermondo/heroku-buildpack-structurizr
```

### How does it work?

*   It depends on the heroku/jvm buildpack being added beforehand as well.
*   It downloads the structurizr war file and puts it into the home directory of the dyno so that you can run it in your dyno.

To run structurizr in a web process you would need to do the following `web: java -Dserver.port=${PORT} -jar structurizr-lite.war .` and then the home directory of the dyno would be the workspace.

[buildpacks]: http://devcenter.heroku.com/articles/buildpacks
[structurizr-lite]: https://structurizr.com/help/lite
