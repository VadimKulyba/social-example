module UsersHelper
  def avatar_for(user, size = 150)
    avatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{avatar_id}?s=#{size}"
  end
end
