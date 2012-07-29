# -*- coding: utf-8 -*-
require "socket"
class Client
  def initialize(ip = "127.0.0.1", port = 3333)
    @ip, @port = ip, port
  end

  def send_message(msg)
    connection do |socket|
      p socket.puts(msg)
      p msg
      res = socket.gets
      return res
    end
  end

  def recieve_message
    connection do |socket|
      res = socket.read
      return res
    end
  end

  private

  def connection
    socket = TCPSocket.new(@ip, @port)
    # socketをブロック内引数としてconnectionメソッドに渡されたブロックを実行
    yield(socket)
  ensure
    socket.close if socket
  end
end

client = Client.new
puts client.send_message("* 5 10")
puts client.send_message("/ 5 10")
puts client.send_message("a b c")
puts client.send_message("/ b c")
puts client.send_message("/ 5 0.6")
