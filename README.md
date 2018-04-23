# Building a coldfusion docker images

## Step 1 - download the linux install binaries for 64 bit linux
https://www.adobe.com/support/coldfusion/downloads.html

## Step 2 - put the files in your download folder

## Step 3 - map your download folder to an http location

I used a temporary nginx instance pointed at my downloads - Example

```
docker run --name nginx-downloads -p 8000:80 -d -v /d/Downloads/:/usr/share/nginx/html nginx
```

## Step 4 - verify the silent.properties

sample one is provided in this repo. save to your downloads folder. Default user/pass is admin/test

Change the user/pass to be whatever you want.

## Step 5 - build the container

In the example below 192.168.138.115 is my IP on my private network. Port 8000 is pointed at that nginx instance aimed at my Downloads folder

build docker image using your IP and the port you mapped the nginx downloads to

```
docker build -t jhgoodwin/coldfusion --build-arg CF_INSTALLER_URL=http://192.168.138.115:8000/ColdFusion_2016_WWEJ_linux64.bin --build-arg CF_SILENT_PROPERTIES_URL=http://192.168.138.115:8000/silent.properties .
```

## Step 6 - run the container

a copy of the test hello world file is in this repo. Use it if you need a test file.
I mapped it to the wwwroot folder to let me try it out.

```
docker run --rm -it -p 8500:8500 -v /c/Temp/cfm/test.cfm:/opt/coldfusion2016/cfusion/wwwroot/test.cfm jhgoodwin/coldfusion
```

This will run it interactive, once it says:
```
Running ColdFusion Server. Press Enter to stop container
```

Then open a browser to:
http://localhost:8500/test.cfm

It should say `Hello World`

The ColdFusion Administrator is also available (case sensitive):

http://localhost:8500/CFIDE/administrator

# References

* https://medium.com/@rhpt/install-coldfusion-11-on-ubuntu-66d2efdf03a2#.28cj9lxws
* https://helpx.adobe.com/coldfusion/installing/installing-the-server-configuration.html
