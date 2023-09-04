require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'
require "date"
require 'open-uri'
require 'json'
require 'net/http'
require 'openai'

enable :sessions

before do
    if session[:user]
        @user = User.find(session[:user])
    end
    @display = Task.where(user_id: session[:user]).limit(5).order(id: :desc)
end

get '/' do
  erb :timecount
end

get '/signup'do
 erb :signup, :layout => false
end

post '/signup' do
    user = User.create(name: params[:name],password: params[:password],
              password_confirmation: params[:password_confirmation],email: params[:email])
    if user.persisted?
     session[:user] = user.id
     redirect 'app_main'
    end
    redirect '/'
end

get '/signout' do
    session[:user] = nil
    redirect '/signin'
end

get '/app_main' do
    erb :app_main
end

get '/signin' do
    erb :signin, :layout => false
end

post '/signin' do
    user = User.find_by(name: params[:name])
    puts User.count
    if user && user.authenticate(params[:password])
        session[:user] = user.id
        redirect '/timecount'
    end
    redirect '/signin'
end

get '/account' do
  @users=User.where(user_id: session[:user])
  @task=Task.where(user_id: session[:user])
  erb :account
end

get '/record' do
  @task=Task.where(user_id: session[:user])
  @category = Category.where(user_id: session[:user])
  category_ids = []
  @task.each do |task|
     category_ids.push(task.category_id)
  end
  @category_id = category_ids.group_by(&:itself).map{|key, value| [value.count] }
  erb :record
end

get '/timecount' do
    @categories = Category.where(user_id: session[:user], is_hidden: false)
    @tasks = Task.where(user_id: session[:user])
    puts @tasks
    if !(@tasks == nil || @tasks.empty?) && @tasks.last.finish_time == nil
        redirect '/task/end'
    end
    erb :timecount
end

post '/category/new' do
    if session[:user]
    Category.create(name: params[:name],color: params[:color], is_hidden: false, user_id: session[:user])
    redirect '/timecount'
    else
    redirect'/signin'
    end
end

post '/task/new' do
    if session[:user]
    start = params[:start_time].to_datetime
    jst = start.new_offset('+0900')
    @task = Task.create(start_time: jst,name: params[:name],category_id: params[:category_id],user_id: session[:user])
    redirect '/task/end'
    else
    redirect'/signin'
    end
end
get '/task/end' do
    @lasttask = Task.last
    # @tasks = Task.all
    # starttime = @lasttask.start_time
    # time = DateTime.now
    # jst = time.new_offset('+09:00')
    # @timepass = jst - starttime
    erb :timecount_end
end

post '/task/insert' do
    @lasttask = Task.last
    @lasttask.finish_time = DateTime.now
    @lasttask.save
    res = @lasttask.finish_time.to_date - @lasttask.start_time.to_date
    # res = @lasttask.finish_time - 3
    puts res
    puts "aaaaaaa"
    redirect '/timecount'
end

post '/task/:id/delete' do
    task = Task.find(params[:id])
    task.destroy
    redirect '/timecount'
end

get '/category' do
    @categories = Category.where(user_id: session[:user], is_hidden: false)
    erb :category
end

get '/category/:id/edit' do
    @category = Category.find(params[:id])
    erb :category_edit
end

post '/category/:id/edit' do
    category = Category.find(params[:id])
    
    category.name = params[:name]
    category.color = params[:color]
    category.save
    redirect '/category'
end

post '/categories/:id/delete' do
    category = Category.find(params[:id])
    category.is_hidden = true
    category.save
    redirect '/category'
end

get '/task/:id/edit' do
    @task = Task.find(params[:id])
    @categories = Category.where(user_id: session[:user], is_hidden: false)
    puts @task
    erb :edit
end

post'/task/:id/edit' do
    start = params[:start_time].to_datetime
    jst = start.new_offset('+0900')
    finish = params[:finish_time].to_datetime
    fin = finish.new_offset('+0900')
    
    task.name = params[:name]
    task.category_id = params[:categiry_id]
    task.start_time = jst
    task.finish_time = fin
end

get '/todo' do
  if session[:user]
  @todo = Todo.find(session[:user])
  @todo1 = Todo.where(user_id: session[:user], category_id: 1, completed: false)
  @todo2 = Todo.where(user_id: session[:user], category_id: 2, completed: false)
  @todo3 = Todo.where(user_id: session[:user], category_id: 3, completed: false)
  @todo4 = Todo.where(user_id: session[:user], category_id: 4, completed: false)
  @todo5 = Todo.where(user_id: session[:user], category_id: 5, completed: false)
  @todo6 = Todo.where(user_id: session[:user], category_id: 6, completed: false)
  @todoc1 = Todo.where(user_id: session[:user], category_id: 1, completed: true)
  @todoc2 = Todo.where(user_id: session[:user], category_id: 2, completed: true)
  @todoc3 = Todo.where(user_id: session[:user], category_id: 3, completed: true)
  @todoc4 = Todo.where(user_id: session[:user], category_id: 4, completed: true)
  @todoc5 = Todo.where(user_id: session[:user], category_id: 5, completed: true)
  @todoc6 = Todo.where(user_id: session[:user], category_id: 6, completed: true)
  end
  erb :todo
end
post '/todo/:id/new' do
    if session[:user]
    jst = DateTime.now 
    Todo.create(name: params[:name],text: params[:text], category_id: params[:id], user_id: session[:user],register_time: jst,completed: false)
    dis = Todo.where(user_id: session[:user]).last.id
    redirect '/todo/detail/'+dis.to_s
    else
    redirect '/signin'
    end
end

get'/todo/detail/:id' do
    @content= Todo.find(params[:id])
    erb :register
end

get '/history' do
    erb :taskrecord
end

get '/todo/:id/complete'do
    todo = Todo.find(params[:id])
    todo.completed = true
    todo.save
    redirect'/todo'
end

get '/todo/:id/delete' do
    todo = Todo.find(params[:id])
    todo.destroy
    redirect'/todo'
end

get '/todo/:id/start' do
    todo = Todo.find(params[:id])
    dis = params[:id]
    todo.completed = true
    todo.save
    redirect '/timecount/'+dis.to_s
end

get'/timecount/:id' do
    @content= Todo.find(params[:id])
    erb :timecount
end

get '/todo/:id/restart' do
    todo = Todo.find(params[:id])
    todo.completed = false
    todo.save
    redirect '/todo'
end