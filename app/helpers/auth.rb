def require_logged_in
  redirect('/login') unless is_authenticated? 
end

def is_authenticated?
  return !!session[:user_id]
end
