get '/' do
  if current_user
    @users = User.all
  end
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  if @user = User.find_by_email(params[:email]) and
  @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to '/'
  else
    @error = "Ooops the email and password you entered don't match"
    @email = params[:email]
    erb :sign_in
  end
end

delete '/sessions/:id' do
  session[:user_id] = nil
  redirect to '/'
end

#----------- USERS -----------

get '/users/new' do
  @user = User.new
  erb :sign_up
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect to '/'
  else
    erb :sign_up
  end
end
