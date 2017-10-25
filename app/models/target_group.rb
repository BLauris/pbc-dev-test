class TargetGroup < ActiveRecord::Base
  
  validates :name, presence: true
  
  belongs_to :panel_provider
  belongs_to :parent, foreign_key: :parent_id, class_name: :TargetGroup 
  has_many :childrens, foreign_key: :parent_id, class_name: :TargetGroup 
  
end
