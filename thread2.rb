def tarefa_multi_thread
  10.times do |i|
    Thread.new do
      sleep(0.1)
      puts "Tarefa #{i}"
    end
  end
end

tarefa_multi_thread
