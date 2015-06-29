title=Getting JSLint to run on a Homebrew-based V8
date=2012-04-04
type=post
tags=mac, homebrew, javascript, jslint, v8
status=published
~~~~~~
Douglas Crockford's [JSLint](http://www.jslint.com) is meant to be run inside a browser. During development, I'd prefer to run it via the command line, using [Google's V8 JavaScript Engine](http://code.google.com/p/v8/) (`brew install v8`). 

<!-- more -->

Fortunately, the real work has already been done in [jslint-v8](https://github.com/geekq/jslint-v8) by [Vladimir Dobriakov](http://www.mobile-web-consulting.de). We just have to figure out how to get the Rakefile to compile against our Homebrew-based V8 installation:

```bash
$ brew install v8
$ cd /tmp
$ git clone git://github.com/geekq/jslint-v8.git && cd jslint-v8
$ V8_BASEDIR=$(brew --prefix v8) rake
$ cp jslint ~/bin/
```

I really should make this a Homebrew formula, but I'll save that for another day.
