# Let's get some superweb powers.

# Make sure to gem install rack first.
require 'rack'

# Okay, we're going to build a quick really simple
# web application.

# Rack is a ruby library for building web applications. Its a lot
# like our CLI class in that it provides an interface. The CLI interface
# is the Command Line, Rack's interface is the browser.

# First we have to do something weird to prevent some bugs for some
# of you. Really ignore this, it isn't a thing.
Signal.trap('INT') {Rack::Handler::WEBrick.shutdown}

# TODO that we're going to make a class called App.
# It basically represents our web application, as if
# it was as real a thing as the Dogs we've been creating.
class App
end

# Like lots of the things we've built so far, that class
# App, it isn't 'a' particular web app, but rather,
# applications in general. If we want to have a web app,
# we need to make a web app.

our_very_first_web_app = App.new

# But our very first web app, well, it doesn't know
# how to do anything. We need to make it useful.
# It needs a call of action.

# A Rack convention is to invoke the `call` method
# of an instance every time a new request from a browser
# comes in.

# If we define a `call` instance method on our App class
# it will instantly become a rack application.

class App
  def call
  end
end

# However, this call method has two issues, one reasonable one,
# and one incidentally complex one.

# The reasonable thing is that our call method does nothing.
# It needs to return a well-formed HTTP response to be
# compatible with the internets.

# A HTTP Response is defined as three components.

  # A Status Code - A number representing the state of the response.
  # When a web server responds to your browser, the first thing
  # it tells you is how everything went. a 200 response means everything
  # is good. A 500 response means the web server broke, sorry. A 400 response
  # means that you made a mistake. A 300 response means we're confused.

  # It's funny that the web is built on machines communicating their
  # status to each other?

  # Response Headers - Some metadata that describes the response.
  # The web is multimedia. We deliver text, and hypertext, and
  # images, and sound, and video, and binary and lolcatz. Data comes
  # in many forms and we handle it all. To make things easy, we
  # describe the data we deliver. Generally, you have to at least
  # specify the type of content your sending back. Sometimes, you have
  # to say more.

  # Response Body - The actual data we want to send.
  # Content is king and it lives in the body of the response. For a web page
  # it's a bunch of HTML. For lots of other stuff, it's a bunch of binary data.
  # But you already know that all data is just bits and characters, so binary,
  # text, images, it's really all the same.

  # The call method expects this response delivered as a 3 part array.
  # [the_code, the_metadata_hash, the_body_array]
  # [200, {'Content-Type' => 'text/html'}, ["Hello World"]]

  # the_body_array is weird. Basically, HTTP supports multi-part
  # responses and thus a Rack response is sent as an array. The
  # first part is consider the main body of the response, it's
  # what we care about.

# Let's add this as the return value for our call method real quick.

class App
  def call
    [200, {'Content-Type' => 'text/html'}, ["Hi from BK-002, we &<3 you!"]]
  end
end

# So now every time a browser makes a request to our Rack Ruby Web
# Server Application, the Rack gem will create a new instance of our application
# and automatically trigger the call method to send back our HTTP 3 Part Response.

# But one more totally unreasonable thing. Web Applications are complex.
# There's a good chance we're not the first application to deal with this
# request. So each Rack Application passes the `call` method an argument,
# the environment of the request thus far. It's complicated and I'll explain it
# but for now, just know that the `call` method must accept an argument
# and we call it env. We don't even need to do anything with it, we just
# must accept it.

class App
  def call(env)
    [200, {'Content-Type' => 'text/html'}, ["Hi from BK-002, we &#9829; you!"]]
  end
end

# And finally, we must instruct our Rack on which web server to use,
# which port to run on, and what object to use as our application.

# Here is our application instance for Rack to use.
our_very_first_web_app = App.new

# Below is the weird Rack::Handler syntax to connect to a Ruby Webserver
# called Webrick (we could use thin or unicorn or mongrel or whatever).

# We call a run method on that handler, pass it our application
# instance, give it a port, and we've built a ruby web application.

Rack::Handler::WEBrick.run(our_very_first_web_app, {:Port => 3000})

# Try this from your terminal (from the root of this project).
# ruby 001.a.basic.rack.app/app.rb

# You should see some output that indicates that you've launched your
# first Ruby web server. Here's what I see.

# $ ruby 001.a.basic.rack.app/app.rb
# [2013-10-18 06:34:13] INFO  WEBrick 1.3.1
# [2013-10-18 06:34:13] INFO  ruby 1.9.3 (2013-06-27) [x86_64-darwin12.3.0]
# [2013-10-18 06:34:13] INFO  WEBrick::HTTPServer#start: pid=18621 port=3000

# So right now, on your computer, using ruby, you just built a web application.
# It's a living thing, waiting on port 3000 of your computer, to respond to
# anything requesting an HTTP response (like your browser). It's running and
# waiting. Let's give it a request to respond to.

# Go get your moment of zen and open the following URL in your browser.

# http://localhost:3000

# localhost is just an easy way to refer to your own computer from your
# own computer. the :3000 part is basically saying which port to use on your
# computer. We'll cover more about this.

# You could also open a new terminal (because you have a running process,
# the web server, in your current one) and type:

# open http://localhost:3000

# That'll trigger your browser. Check your terminal, you should see a log
# response that your application handled the request from the browser.

# localhost - - [19/Oct/2013:06:41:47 EDT] "GET / HTTP/1.1" 200 33 - -> /

# That's a web application. Cool, right?

# But obviously there's more. See the thing is, in our application, that
# string "Hi from Ruby 004, we &#9829; you!", we're sending, well, it's
# totally arbitrary. We can build that string whenever we want, injecting
# any content we want, at any time, and people will see it, changing, coming to life.

# Let's go to 002, but first, exit your first web application by pressing
# Control+C in the terminal window that has your application running.

# You should see.
# ^C[2013-10-19 06:41:53] INFO  going to shutdown ...
# [2013-10-19 06:41:53] INFO  WEBrick::HTTPServer#start done.
