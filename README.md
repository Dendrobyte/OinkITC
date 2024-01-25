# OinkITC

Welcome to OinkITC! This game is my second game project (the first was a Tetris clone). It is inspired by the original [One in the Chamber](https://callofduty.fandom.com/wiki/One_in_the_Chamber) gamemode from Call of Duty. I first wrote the game [as a Minecraft plugin](https://github.com/oinkcraft/OneInTheChamber) a few years ago. The name / acronym will have to change, but for now "Oink" comes from that Minecraft server being named "Oinkcraft".

You can find a devlog to wrap up the project [on my YouTube channel!](http://www.youtube.com/markbacon78)

## Goals

This game is meant to be a _learning endeavor._ My primary focus is creating a multiplayer game; both game and server. I've avoided networking my whole life but I've been surprisingly fascinated by it reading lately, and I've started with [Beej's Guide(s)](https://beej.us/guide/). Anyway, you can find the milestones for the game below. My deadline is **March 3rd, 2024** (so roughly six weeks; or if I hit 60 hours on the project). I will aim to meet these milestones and optionally spend more time on the game, but it will largely be imperfect.

### Milestones (Completion Requirements)

- [ ] The game will be made using entirely my own assets, no matter how garbage (aside from 2D UI assets)
- [ ] A fully functional One in the Chamber gameplay loop
- [ ] Proper start menu and settings, though minimal
- [ ] A multiplayer game server that handles all communication
- [ ] The game has fun movement, and time is spent on it
- [ ] Releasing the game on itch.io
- [ ] There is at least one playtesting session

There are some bonus milestones but that's for later :)

## Repository Organization

The game is written in Godot, and (as of now, at least) the server is written in Golang. You can find the Godot project files in [**oitc_game**](/oitc_game) and the Go server files in [**oitc_server**](/oitc_server).

There are respective README files in those directories, such as how to set up the server and anything you might need to know about the game.
