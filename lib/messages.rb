module Messages

  # Retrieve messages for a user -- all, or by page_number iff passed
  def get_messages(page_number = 1)
    if page_number == nil
        response = self.class.get(base_uri("message_threads"), headers: { "authorization" => @auth_token })
      else
        response = self.class.get(base_uri("message_threads/"), headers: { "authorization" => @auth_token },
          body: { "page" => page_number })
    end
    JSON.parse(response.body)
  end

  # Create a message for user
  def create_message(sender, recipient_id, token, subject, stripped_text)
    response = self.class.put(base_uri("message"),
      headers: { "authorization" => @auth_token },
      body: {
        "sender" => sender,
        "recipient_id" => recipient_id,
        "token" => token,
        "subject" => subject,
        "stripped_text" => stripped_text
        })
    puts response if response.success?
  end

end
