def tarefa_multi_thread
  threads = []
  10.times do |i|
    thread = Thread.new do
      sleep(0.1)
      puts "Tarefa #{i}"
      $stdout.flush
    end
    threads << thread
  end

  threads.each(&:join)
end

tarefa_multi_thread
