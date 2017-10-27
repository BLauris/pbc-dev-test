class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :external_id, :secret_code, :country_id, :country_code
  
  def country_id
    object.country.id
  end
  
  def country_code
    object.country.country_code
  end
  
end
