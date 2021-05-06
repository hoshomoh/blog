## O_o

This is my official website and blog.

### Build and Serve 

```shell script
docker run -rm -it \
  --volume="$PWD:/srv/jekyll" \
  --volume="$PWD/vendor/bundle:/usr/local/bundle" \
  -p 4000:4000 jekyll/jekyll:4.0 \
  jekyll serve
```

### Deploy

```shell script
docker run -rm -it \
  --volume="$PWD:/srv/jekyll" \
  --volume="$PWD/vendor/bundle:/usr/local/bundle" \
  -p 4000:4000 jekyll/jekyll:4.0 \
  jekyll build

rake -f UploadToGithub.Rakefile
```

### Post and Pages

To manage post and pages creation, I use jekyll compose. You can check the docs [here](https://github.com/jekyll/jekyll-compose).
