## O_o

This is my official website and blog.

### Build and Serve 

```shell script
make serve
```

### Deploy

Create production build:

```shell script
make shell

jekyll build

rake -f UploadToGithub.Rakefile
```

Push changes to master:

```shell script
rake -f UploadToGithub.Rakefile
```

### Post and Pages

To manage post and pages creation, I use jekyll compose. You can check the docs [here](https://github.com/jekyll/jekyll-compose).
