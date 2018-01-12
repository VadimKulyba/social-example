module UsersHelper
  def avatar_for(user)
    avatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{avatar_id}"
  end
end
