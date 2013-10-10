require 'pry'
require 'pry-byebug'

require 'sinatra'
require 'sinatra/contrib/all'

set :questions, { 
  1 => ["Ruby is awesome?", true],
  2 => ["The code <pre><code>2+2</code></pre> gives the result <pre><code>4</code></pre>", true]
}

enable :sessions

get "/" do
  erb :welcome
end

get "/questions/:question_id" do
  session["answers_from_user"] = {} 
  @question_id = params[:question_id].to_i # because your params is a string
  @question = settings.questions[@question_id].first # .first gives you the first value of the array; looks nicer than [0]
  session["answers_from_user"] = [params[:answered_id], params[:answer]]
  if @question_id != settings.questions.size
    @next = "/questions/#{@question_id + 1}"
  else
    @next = "/result"
  end
  erb :question
end

get "/result" do
  session["answers_from_user"].each do |q, a|
    @score += 1 if a == settings.questions[q].last.to_s
  end
  @score.to_s
  erb :result
end
