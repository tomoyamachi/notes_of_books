# -*- coding: utf-8 -*-
require "socket"
class StandardError
  def report
    puts %{#{self.class}: #{message}}
  end
end
class Server
  def initialize(port=3333)
    @server=TCPServer.new('127.0.0.1',port)
    @handlers = {}
  end

  def *(x,y)
    (Float(x) * Float(y)).to_s
  end

  def /(x,y)
    Float(x) / Float(y)
  end

  def handle_request(session)
    action, *args= session.gets.split(/\s/)
    if %w[/ *].include? action
      session.puts send(action, *args)
    else
      session.puts "Invalid"
    end
  rescue StandardError => e
    puts e.report
    session.puts "Something went wrong"
  end

  def run
    while session = @server.accept
      handle_request(session)
    end
  end
end
begin
  server=Server.new
  server.run
rescue StandardError => e
  puts "Something fatal error"
end
