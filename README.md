Mashup your bash-fu with coffeescript-fu in the console with coffeepipe

<img alt="" src="http://coffeescript.org/documentation/images/logo.png"/>

> npm install coffeescript coffeepipe-bash -g

## How to use 

Just fire up a terminal and start hacking away.
This turns coffeescript into a nifty awk/swish armyknife-ish tool.

## Examples

> Simple eval 

    $ cfp 'new Date().toString()'

> search / replace

    $ echo "foo"           | cfp '(s) -> s.replace /foo/, "bar"'

> process line by line

    $ echo -e "foo\nbar"   | cfp '(s) -> ( "output: #{line}" for line in s.split "\n")'

> filter by coffeescript file

    $ echo -e "foo\nbar"   | cfp ./filter.coffee 

> automatically convert array to lines 

    $ echo "one,two,three" | cfp '(s) -> s.split ","'

> detect json / indent json

    $ echo "[1,2,3,4]"     | cfp '(s) -> JSON.stringify(s,null,2)'

> cherrypick from JSON

    $ curl -s https://api.github.com/users/coderofsalvation/repos | cfp 'input[0].name'

> print x items from JSON

    $ curl -s https://api.github.com/users/coderofsalvation/repos | cfp '(s) -> ( input.data[i].name for i in [0..4] )'

> transform json

    $ curl -s https://api.github.com/users/coderofsalvation/repos | ./cli.coffee '(s) -> input.data = input.data.slice(0,4) ; return input'

