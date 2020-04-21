## Workflow
1. If you want to create the new xxh-shell entrypoint you should have portable version of the shell. It could be static binary, [AppImage](https://appimage.org/), [Flatpak](https://www.flatpak.org/), [zipapp](https://docs.python.org/3.5/library/zipapp.html), or any other way to run shell without dependencies.
2. Fork this repo to create your [xxh](https://github.com/xxh/xxh) shell entrypoint.
3. Rename your repo to `xxh-shell-myshell`
4. Install [xxh](https://github.com/xxh/xxh) and run once to creating `~/.xxh`
5. `cd ~/.xxh/xxh/shells && git clone https://github.com/you/xxh-shell-myshell && cd xxh-shell-myshell`
6. Edit `build.sh` script. While build you should create `build` directory with minimal group of files to run the portable shell.
7. Edit `entrypoint.sh` script. This script should be copied to `build` directory while building and this script will be the main entrypoint to the shell.
8. Run `./build.sh`. It will be great if after building you can run `build/entrypoint.sh` and open the shell locally.
9. Try to connect: `xxh myhost +if +s xxh-shell-myshell` (`+if` means force reinstall).
10. Try to use commands, try to move thru directories. If everything as expected try commit and push your changes.
11. You rock! [Tell us about your work](https://gitter.im/xonssh-xxh/community)!

## xxh-shell example

Real life example of creating xxh-shell and xxh-plugins you could find in [xxh-shell-xonsh](https://github.com/xxh/xxh-shell-xonsh).

## Plugins

To support plugins to your xxh-shell you should add execution the `pluginrc` files. Examples: [.zshrc](https://github.com/xxh/xxh-shell-zsh/blob/master/.zshrc), [xonshrc](https://github.com/xxh/xxh-shell-xonsh/blob/master/xonshrc.xsh).

## Seamless mode
The xxh has seamless environment mode which allows to pass variable from your current shell session 
to the xxh host session. For example if you have `XONSH_COLOR_STYLE` variable with your shell color theme you shouldn't
worry about passing it manually. Example for xonsh: 
```
home> print($XONSH_COLOR_STYLE)
paraiso-dark
home> source xxh.xsh myhost
myhost> print($XONSH_COLOR_STYLE)
paraiso-dark
``` 
This very useful when you want to use the same tools on your local and remote host. 
