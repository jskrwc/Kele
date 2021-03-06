module Roadmap

  # Retrieve Roadmaps
  def get_roadmap(chain_id)
    response = self.class.get(base_uri("roadmaps/#{chain_id}"), headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  # Retrieve Checkpoint ID's from get_roadmap response
  def get_checkpoint(checkpoint_id)
    response = self.class.get(base_uri("checkpoints/#{checkpoint_id}"), headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_remaining_checkpoints(chain_id)
    response = self.class.get(base_uri("enrollment_chains/#{chain_id}/checkpoints_remaining_in_section"),
    headers: { "authorization" => @auth_token })
    # puts response.success?
    # puts response.inspect
    JSON.parse(response.body)
  end

end
