# huvud

Testing – for fun and profit.

Start:

    foreman start

Open [http://localhost:5000/](http://localhost:5000/).

Or debug (only `RACK_ENV=development`)

    $ bundle exec racksh
    Rack::Shell v1.0.0 started in development environment.
    [1] pry(main)> $rack.get '/debug'

URLs:

* http://huvud.herokuapp.com
* https://huvud.herokuapp.com
* http://huvud.starkast.net
* https://huvud.starkast.net
* https://huvud.fly.dev

## Deployment

Deployed on [Fly.io](https://fly.io).

```bash
# initial setup, create
fly apps create --org personal --name huvud

# delpoy
fly deploy
```
