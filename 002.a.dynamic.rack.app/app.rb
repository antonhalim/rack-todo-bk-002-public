# Again, ignore the following line.
Signal.trap('INT') {Rack::Handler::WEBrick.shutdown}

# We left off with this amazing but boring Ruby Rack powered
# application.

class App
  def call(env)
    [200, {'Content-Type' => 'text/html'}, ["Hi from BK-002, we &#9829; you!"]]
  end
end

# But wait, if we're going to be building Rack applications,
# we have to integrate that superpower into this current script.

require 'rack'

# Okay, so now we know that application above will respond with a static string.
# But what about a more complex one?

class App
  def call(env)
    seconds_in_56_days = 4838400 # I hope that's right.

    # Here comes a HERE doc. It's just a ruby string.
    response = <<-TXT
    Hi Ruby 006. It's #{Time.now}.
    Hit refresh and realize you've been learning Ruby
    since #{(Time.now - seconds_in_17_days)}.
    How many days is that? 56? With weekends? And look what you're doing.
    Building a dynamic web application. I wonder what else you're capable of.
    TXT

    # And now instead of a static string in the body of the response,
    # we'll send our variable, response. And every request, it's value
    # will be different.

    [200, {'Content-Type' => 'text/html'}, [response]]
  end
end

# Okay and now our Rack Handler to actually load the application
# on port 3001 of our computer.

Rack::Handler::WEBrick.run(App.new, {:Port => 3001})

# You should see the Rack output letting you know you have a server
# running, this time on port 3001.

# Open your browser again to http://localhost:3001

# And every time you hit refresh in your browser, you've been learning
# ruby for that much longer. Gives new meaning to this Sandi Metz quote.

# "You'll never be as stupid as you are right now."

# Hit refresh again, you've just gotten a few seconds smarter,
# a moment more familiar with Ruby.

# Okay, exit out of that server, shut it down with CTRL+C

# So we can put anything in that response? Hmm. I wonder what we can do...

# Continue to 003.magic.rack.app
