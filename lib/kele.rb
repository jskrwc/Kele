require 'httparty'
require 'json'


class Kele
  include HTTParty

  def initialize(email, password)
    response = self.class.post(base_uri("sessions"), body: {
      email: email,
      password: password
    })
    @auth_token = response['auth_token']
    raise "Invalid email or password - try again!" if @auth_token.nil?
  end


  def get_me
    response = self.class.get(base_url("users/me"), headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end


  private

  def base_uri(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
