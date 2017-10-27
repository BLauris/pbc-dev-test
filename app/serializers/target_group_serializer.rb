class TargetGroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :external_id, :parent_id, :secret_code
  
end