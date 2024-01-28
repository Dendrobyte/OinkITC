# OinkITC Server

## Running the Server

The `main.go` file is (obviously) the main entry point to the server. You can run it with `go run main.go` and it will start a TCP listener on `localhost:6767` (you can change these to whatever you want- `serverAddress` on line 12).

I like to work with live reloading, so I've installed [`cosmtrek/air`](https://github.com/cosmtrek/air) which you can run with just `air` in the `/oitc_server` directory. It checks for changes every 1 second and can be kind of annoying, but since startup is fast I just put it in a terminal window and forget about it in the background.

To access from external services, you're going to have to set up port forwarding, etc. But as for starting the server up, that's literally it! CTRL+C to take it down.

## Contributing

I probably won't fill out development practices but in the off chance you have questions and/or want to fork this for anything- please reach out! @Mobkinz78 on Twitter or just via GitHub somehow?

I do have intentions to expand upon this since ultimately I want to make a multiplayer game, and it would be nice to have a server that works for more than just one game. For now it's small-ish projects to get my ball rolling.
