Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "488372523971-9tl49uq162ea8ch1l6uuekqtcgf1dvk2.apps.googleusercontent.com", "BeAk7y2LiZhoFu8zJ247Zy01",
    {
    access_type: 'online'
  }

end
