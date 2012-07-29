require "socket"
class Server
  def initialize(port=3333)
    @server=TCPServer.new('127.0.0.1',port)
    @handlers = {}
  end

  def handle(pattern,&block)
    @handlers[pattern] = block
  end

  def run
    while session = @server.accept
      msg = session.gets
      match = nil

      @handlers.each do |pattern, block|
        if match = msg.match(pattern)
          break session.puts(block.call(match))
        end
      end

      unless match
        session.puts "Undefined msg : #{msg}."
      end
    end
  end
end

server= Server.new
server.handle(/hello/i) { "Hello #{Time.now}."}
server.handle(/goodbye/i) { "Goodbye #{Time.now}."}
server.handle(/name is (\w+)/) { |name| "Name is #{name[1]}."}

server.run
