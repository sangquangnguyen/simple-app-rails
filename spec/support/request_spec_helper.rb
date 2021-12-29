module RequestSpecHelper
  def sign_in(email, password)
    post '/login', params: { session: { email: email, password: password } }
  end
end
