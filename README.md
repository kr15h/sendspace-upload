# SendSpace Upload

This simple `bash` script that uploads a file to SendSpace and gives you back download and delete URL's for further action. Initially I was trying to do it with Python until I discovered how easy it is to simulate multipart form with `curl`. Adding a pinch of `sed` knowledge I managed to achieve success.

## Usage

First go to [SendSpace Developer API Keys](# https://www.sendspace.com/dev_apikeys.html) page and generate an API key. Open up `upload.sh` and put your API key there.

```
API_KEY="your-key-here"
```

Edit the path to file you want to upload.

```
FILE="your-file.zip.or.not"
```

Save and close. Run it.

```
./upload.sh
```

You should see output that is similar to the one below.

```
Uploading cat.png...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  267k    0   315  100  267k    231   196k  0:00:01  0:00:01 --:--:--  196k
Upload successful.
Dowload URL: https://www.sendspace.com/file/8pbacv
Delete URL: https://www.sendspace.com/delete/8pbacv/bc35adc2028de0b4bf3bab542488120a
```

Use the Download URL to dowload and Delete URL to delete the file from SendSpace servers. 

## MAC vs Linux

If you experience problems running this, it might be because of the version of `sed` you are using. Try replacing `sed -E` with `sed -r` and see what happens. Otherwise read below what this flag stands for.

```
Use extended regular expressions rather than basic regular expressions. Extended regexps are those that egrep accepts; they can be clearer because they usually have fewer backslashes. Historically this was a GNU extension, but the -E extension has since been added to the POSIX standard (http://austingroupbugs.net/view.php?id=528), so use -E for portability. GNU sed has accepted -E as an undocumented option for years, and *BSD seds have accepted -E for years as well, but scripts that use -E might not port to other older systems. See Extended regular expressions.
```

From [GNU sed manual](https://www.gnu.org/software/sed/manual/sed.html#Command_002dLine-Options).
