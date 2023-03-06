# nvim-server
Build neovim based IDE docker , could also use on webGUI


Build docker image
```
./build.sh
```

Start docker 
```
docker run -p 3000:3000 -it nvim-server:latest
```

Access url , http://<server>:3000/wetty
