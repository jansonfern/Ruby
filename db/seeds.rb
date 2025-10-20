# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create admin users
admin_user = User.find_or_create_by!(email: 'admin@quiz.com') do |user|
  user.name = 'Administrador'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = 'admin'
end

# Test admin user requested
test_admin = User.find_or_create_by!(email: 'admin@gmail.com') do |user|
  user.name = 'Admin Teste'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = 'admin'
end

# Create moderator user
moderator_user = User.find_or_create_by!(email: 'moderator@quiz.com') do |user|
  user.name = 'Moderador'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = 'moderator'
end

# Create student user
student_user = User.find_or_create_by!(email: 'student@quiz.com') do |user|
  user.name = 'Estudante'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = 'student'
end

puts "Created users: #{User.count}"
puts "Test admin present: #{User.exists?(email: 'admin@gmail.com')}"

# Create questionnaires
questionnaires_data = [
  {
    title: "Quiz de Ruby on Rails",
    code: "ROR001",
    description: "Teste seus conhecimentos em Ruby on Rails, incluindo MVC, ActiveRecord, rotas e convenções.",
    duration_minutes: 30,
    total_questions: 5,
    active: true,
    user: admin_user
  },
  {
    title: "Quiz de JavaScript",
    code: "JS001",
    description: "Avalie seu conhecimento em JavaScript, incluindo ES6+, DOM, eventos e programação assíncrona.",
    duration_minutes: 20,
    total_questions: 5,
    active: true,
    user: admin_user
  },
  {
    title: "Quiz de Python",
    code: "PY001",
    description: "Teste seus conhecimentos em Python, incluindo sintaxe, estruturas de dados e bibliotecas padrão.",
    duration_minutes: 25,
    total_questions: 5,
    active: true,
    user: moderator_user
  },
  {
    title: "Quiz de React",
    code: "REACT001",
    description: "Avalie seu conhecimento em React, incluindo componentes, hooks, estado e ciclo de vida.",
    duration_minutes: 35,
    total_questions: 5,
    active: true,
    user: admin_user
  }
]

questionnaires_data.each do |data|
  questionnaire = Questionnaire.find_or_create_by!(code: data[:code]) do |q|
    q.title = data[:title]
    q.description = data[:description]
    q.duration_minutes = data[:duration_minutes]
    q.total_questions = data[:total_questions]
    q.active = data[:active]
    q.user = data[:user]
  end
  puts "Created questionnaire: #{questionnaire.title}"
end

# Create questions for Ruby on Rails quiz
ror_quiz = Questionnaire.find_by(code: 'ROR001')
if ror_quiz
  ror_questions = [
    {
      enunciation: "Qual comando gera um model no Rails?",
      position: 1,
      options: [
        { title: "rails generate model", correct: true, position: 1 },
        { title: "rails new model", correct: false, position: 2 },
        { title: "rails create model", correct: false, position: 3 },
        { title: "rails make model", correct: false, position: 4 }
      ]
    },
    {
      enunciation: "Qual é o padrão de arquitetura do Rails?",
      position: 2,
      options: [
        { title: "MVC", correct: true, position: 1 },
        { title: "MVVM", correct: false, position: 2 },
        { title: "MVP", correct: false, position: 3 },
        { title: "Clean", correct: false, position: 4 }
      ]
    },
    {
      enunciation: "Onde você define as rotas no Rails?",
      position: 3,
      options: [
        { title: "config/routes.rb", correct: true, position: 1 },
        { title: "app/routes.rb", correct: false, position: 2 },
        { title: "lib/routes.rb", correct: false, position: 3 },
        { title: "routes/config.rb", correct: false, position: 4 }
      ]
    },
    {
      enunciation: "Qual comando inicia o servidor Rails?",
      position: 4,
      options: [
        { title: "bin/rails server", correct: true, position: 1 },
        { title: "rails start", correct: false, position: 2 },
        { title: "rails run", correct: false, position: 3 },
        { title: "ruby server.rb", correct: false, position: 4 }
      ]
    },
    {
      enunciation: "Qual é a função do ActiveRecord?",
      position: 5,
      options: [
        { title: "Mapear objetos para tabelas do banco", correct: true, position: 1 },
        { title: "Gerenciar assets front-end", correct: false, position: 2 },
        { title: "Servir arquivos estáticos", correct: false, position: 3 },
        { title: "Enviar emails", correct: false, position: 4 }
      ]
    }
  ]

  ror_questions.each do |q_data|
    question = ror_quiz.questions.find_or_create_by!(enunciation: q_data[:enunciation]) do |q|
      q.position = q_data[:position]
    end

    q_data[:options].each do |opt_data|
      question.question_options.find_or_create_by!(title: opt_data[:title]) do |opt|
        opt.correct = opt_data[:correct]
        opt.position = opt_data[:position]
      end
    end
  end
  puts "Created #{ror_quiz.questions.count} questions for Ruby on Rails quiz"
end

# Create questions for JavaScript quiz
js_quiz = Questionnaire.find_by(code: 'JS001')
if js_quiz
  js_questions = [
    {
      enunciation: "Qual palavra-chave declara uma variável mutável com escopo de bloco?",
      position: 1,
      options: [
        { title: "let", correct: true, position: 1 },
        { title: "const", correct: false, position: 2 },
        { title: "var", correct: false, position: 3 },
        { title: "mutable", correct: false, position: 4 }
      ]
    },
    {
      enunciation: "Qual método do Array cria um novo array com elementos que atendem a uma condição?",
      position: 2,
      options: [
        { title: "filter", correct: true, position: 1 },
        { title: "map", correct: false, position: 2 },
        { title: "forEach", correct: false, position: 3 },
        { title: "reduce", correct: false, position: 4 }
      ]
    },
    {
      enunciation: "Qual é o resultado de typeof null?",
      position: 3,
      options: [
        { title: "object", correct: true, position: 1 },
        { title: "null", correct: false, position: 2 },
        { title: "undefined", correct: false, position: 3 },
        { title: "number", correct: false, position: 4 }
      ]
    },
    {
      enunciation: "Qual operador espalha os elementos de um array?",
      position: 4,
      options: [
        { title: "...", correct: true, position: 1 },
        { title: "??", correct: false, position: 2 },
        { title: "+", correct: false, position: 3 },
        { title: "*", correct: false, position: 4 }
      ]
    },
    {
      enunciation: "Qual método converte uma string JSON para objeto?",
      position: 5,
      options: [
        { title: "JSON.parse", correct: true, position: 1 },
        { title: "JSON.stringify", correct: false, position: 2 },
        { title: "Object.parse", correct: false, position: 3 },
        { title: "toJSON", correct: false, position: 4 }
      ]
    }
  ]

  js_questions.each do |q_data|
    question = js_quiz.questions.find_or_create_by!(enunciation: q_data[:enunciation]) do |q|
      q.position = q_data[:position]
    end

    q_data[:options].each do |opt_data|
      question.question_options.find_or_create_by!(title: opt_data[:title]) do |opt|
        opt.correct = opt_data[:correct]
        opt.position = opt_data[:position]
      end
    end
  end
  puts "Created #{js_quiz.questions.count} questions for JavaScript quiz"
end

puts "Seeds completed successfully!"
puts "Total questionnaires: #{Questionnaire.count}"
puts "Total questions: #{Question.count}"
puts "Total question options: #{QuestionOption.count}"
