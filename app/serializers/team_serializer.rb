class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :seed, :region, :logo_url, :is_eliminated

  def logo_url
    "#{ENV['DEFAULT_HOST']}assets/#{object.logo_path}"
  end
end
