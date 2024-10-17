class MinhaTarefa
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def run
    sleep(0.1)
    puts "Tarefa #{@id}"  
  end
end

def tarefa_com_classe
  threads = []
  10.times do |i|
    thread = Thread.new(MinhaTarefa.new(i)) do |tarefa|
      tarefa.run  
    end
    threads << thread
  end

  threads.each(&:join)
end

tarefa_com_classe
