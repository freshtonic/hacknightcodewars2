
# HackNightCodeWarZ ][

This time it's distributed.

(yeah - yeah, the tag line sucks).

This month's challenge a Tweet-flavoured, escapade into the world of map/reduce, using Riak and
a corpus of about twenty thousand tweets I scraped off all your timelines...

## Steps

### OSX

Install Erlang

    sudo port install erlang
  
or

    brew install erlang # This is actually a total guess, I haven't migrated yet...

Install Riak

    git clone git://github.com/basho/riak.git
    cd riak
    make rel

### Linux (Ubuntu or Debian)

Install Erlang

    sudo apt-get install erlang
  
Install Riak

If you already have Riak installed and you'd rather not bone your current installation, then install the same was as for OSX. Otherwise just:

    sudo apt-get install riak
    
## Configure Riak

Inside your Riak installation edit rel/riak/etc/app.config, and change everything that looks like an IP address to your IP address on the network. _IMPORTANT_.

In rel/riak/etc/vm.args change the IP address to the be the same as above, but set the cookie to 'hacknight' without the quotes.

Riak should now start with the following command:

    rel/riak/bin/riak start
    
Riak should now be up and running.  BUT you haven't joined your node with any other nodes yet to make a cluster!

### Get cosy with another Riak node to make a cluster
  
This step will need a bit of coordination.

Initially, we'll have a bunch of standalone Riak instances running that aren't aware of each other.  Let's call those A,B,C.

In order to join A & B, on A we issue the following command (where the IP address is B's IP address)

    rel/riak/bin/riak-admin join riak@192.168.1.23
    
To check you can run the following command on A or B:

    rel/riak/bin/riak-admin status | grep ring_members
    
Should show some output like this (with different IPs of course)

    ring_members : ['riak@192.168.1.10','riak@192.168.1.11']
    
The cool thing is, when you join C to A, it will learn about B automatically and so on.  Eventually we should see a ring member for every node.

### Install the script dependencies

Install bundler if you haven't done that yet.

    gem install bundler
    
Then make a bundle:

    bundle install
    
### Update the config file

Change the IP address in config/ripple.yml to your IP address.

### Insert some tweets

Run the following command to put some tweets in Riak:

    bin/install_tweets tweets/$YOUR_TWITTER_NAME*.json

The nifty thing about this, is that the tweets will be distributed throughout the cluster and don't just live on your own box.  Nice!

### Run the test map/reduce script

There is a script bin/mapreduce that will perform a cumulative word count of all the tweets that have been uploaded to the cluster.  Run that and make sure it works.  Note that the result will vary while people are uploading their tweets.

## The challenge!

The challenge is the same format as last month.  You will be put into random pairs, and will attempt to answer the following questions using the Riak map/reduce functionality:

1. Who swears the most?
2. Who sleeps the least?
3. What are the top ten most re-tweeted tweets?

Points go to the most elegant & creative solutions.  I don't know the answers :)
