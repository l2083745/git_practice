require 'sinatra'
require 'sqlite3'
require 'securerandom'
require 'sinatra/reloader'

db = SQLite3::Database.new'db/form.db'
db.results_as_hash = true

get '/form' do
   @title = "llll"

   erb :index
end

post '/comment_send' do

   name = params[:mesnameage]
   title = params[:title]
   message = params[:message]

   stmt = db.prepare('INSERT INTO comments  (name, title, contents) VALUES(?, ?, ?)')
   stmt.bind_params(params["name"], params["title"], params["contents"])
   stmt.execute

   redirect '/list;
end

get '/list' do
    comments = db.execute('SELECT * FROM comments')
    locals = {
           comments: comments
      
        }
    erb :comments, :locals =>locals
end

post '/list_post' do
    comments = params['comments'] 

    stmt = db.prepare('INSERT INTO comments  (name, title, contents) VALUES(?, ?, ?)')
    stmt.bind_params(params["name"], params["title"], params["contents"])
    stmt.execute

    redirect '/comments'
      
end
