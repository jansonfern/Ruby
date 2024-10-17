class MinhaTarefa
  attr_reader :id, :data

  def initialize(id, data)
    @id = id
    @data = data
  end

  def run
    sleep(0.1)
    puts "Tarefa #{id} com dados: #{@data}"
  end
end

def tarefa_com_classe
  threads = []
  10.times do |i|
    thread = Thread.new(MinhaTarefa.new(i, "Algum dado #{i}")) do |tarefa|
      tarefa.run
    end
    threads << thread
  end

  threads.each(&:join)
end

tarefa_com_classe
