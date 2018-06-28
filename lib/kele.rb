require 'httparty'
require 'json'
require './lib/roadmap'


class Kele
  include HTTParty
  include Roadmap

  # Intitailzie and Authorize keleclient w user creds
  def initialize(email, password)
    response = self.class.post(base_uri("sessions"), body: {
      email: email,
      password: password
    })
    @auth_token = response['auth_token']
    raise "Invalid email or password - try again!" if @auth_token.nil?
  end

  # Get the Current User -- return data as hash
  def get_me
    response = self.class.get(base_uri("users/me"), headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  # Get Mentor Availability -- return data as array
  def get_mentor_availability(mentor_id)
    response = self.class.get(base_uri("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    available_times = [] #  convert JSON.parse(response.body) data to array of open time slots

    JSON.parse(response.body).each do |time|
      if time["booked"].nil?
        available_times << time
      end
    end
    available_times
  end

  # Set up Bloc API url -  pass endpoint to be appended to url
  def base_uri(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
