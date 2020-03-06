## Workflow

1. Fork this repo to create your [xxh](https://github.com/xxh/xxh) shell entrypoint.
2. Rename your repo to `xxh-shell-myshell`
3. Install [xxh](https://github.com/xxh/xxh) and run once to creating `~/.xxh`
4. `cd ~/.xxh/shells && git clone https://github.com/you/xxh-shell-myshell && cd xxh-shell-myshell`
5. Edit `build.xsh` script
6. Edit `entrypoint.sh` script
7. Run `./build.xsh`
8. Try to connect `xxh myhost +s xxh-shell-myshell`
9. If everything works commit and push your changes
10. You rock! [Tell us about your work](https://gitter.im/xonssh-xxh/community)!

## xxh-shell example

Real life example of creating xxh-shell and xxh-plugins you could find in [xxh-shell-xonsh-appimage](https://github.com/xxh/xxh-shell-xonsh-appimage).