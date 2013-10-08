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
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase 
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=250"  
  end

   def date_formatter(date)
    formatted_date = date.to_date
    formatted_date = formatted_date.to_formatted_s(:long)
  end

end
