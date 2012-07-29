# -*- coding: utf-8 -*-
require "socket"
#先に ruby dynaic_callback.rb & でサーバの準備をしておく
class Client
  def initialize(ip = "127.0.0.1", port = 3333)
    @ip, @port = ip, port
  end

  def send_message(msg)
    connection do |socket|
      socket.puts(msg)
      socket.gets
    end
  end

  def recieve_message
    connection do |socket|
      socket.gets
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
puts "Client.open"
["Hello", "My name is Greg", "See you Tomorrow", "Goodbye"].each do |msg|
  response = client.send_message(msg)
  puts response
end
