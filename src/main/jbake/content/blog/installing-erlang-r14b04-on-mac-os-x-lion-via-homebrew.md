title=Installing Erlang R14B04 on Mac OS X 10.7.3. "Lion" via homebrew
date=2012-03-27
type=post
tags=mac, lion, erlang, homebrew
status=published
~~~~~~
While `brew install erlang` sounds easy enough, it won't give us what we need for 2 reasons:

* It will install Erlang R15B instead of R14B04 (`brew info erlang` tells us the latest version available via [Homebrew](http://mxcl.github.com/homebrew/) is R15B).
* Erlang won't compile unless you use GCC, which isn't available in Lion or the current version of Xcode (4.3.2).

<!-- more -->

To tackle the first problem, let's find out which versions of Erlang are available:

```bash
$ brew versions erlang
R15B     git checkout 12b8d77 /usr/local/Library/Formula/erlang.rb
R14B04   git checkout 8560672 /usr/local/Library/Formula/erlang.rb
R14B03   git checkout 9332ca9 /usr/local/Library/Formula/erlang.rb
R14B02   git checkout b782d9d /usr/local/Library/Formula/erlang.rb
...
```

In order to select R14B04, we just need to execute the provided command:

```bash
$ cd $(brew --prefix)
$ git checkout 8560672 /usr/local/Library/Formula/erlang.rb
```

(In case `brew` complains about a missing `git` repository, just run `brew update` and try again. This should only happen with new `brew` installations.)

`brew info erlang` should now list R14B04 as the selected version, but trying to install via `brew install erlang` will fail with compiler errors. The solution is to instruct `brew` to use `gcc` for compilation (instead of `llvm-gcc` or `clang`). 
Unfortunately, `gcc` isn't available in Lion _or_ the standard Homebrew formula repository. We therefore have to install it from Homebrew's dupes repository:

```bash
$ brew install https://raw.github.com/Homebrew/homebrew-dupes/master/apple-gcc42.rb
```

Now it's time to actually install Erlang using `gcc` (this may take a while):

```bash
$ brew -v install --use-gcc erlang
```

If all goes well, the Erlang shell should now work and show us it's running on Erlang R14B04:

```bash
$ erl
Erlang R14B04 (erts-5.8.5) [source] [64-bit] [smp:4:4] [rq:4] [async-threads:0] [hipe] [kernel-poll:false]
...
```

Finally, we can now go on to install [Rebar](https://github.com/basho/rebar/wiki), an Erlang build tool. We need to provide the `--HEAD` option, since Rebar "is a head-only formula" (fortunately, `brew` is smart enough to tell you what to do about that in case you forgot):

```bash
$ brew -v install --HEAD rebar
```
