module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def gravatar_url(user)  
    gravatar_id = Digest::MD5::hexdigest(current_user.email).downcase 
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=250"  
  end

end
