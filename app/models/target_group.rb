class TargetGroup < ActiveRecord::Base
  acts_as_nested_set
  
  validates :name, presence: true
  
  belongs_to :panel_provider
  has_many :countries, through: :panel_provider
  
  belongs_to :parent, foreign_key: :parent_id, class_name: :TargetGroup 
  has_many :childrens, foreign_key: :parent_id, class_name: :TargetGroup 
  
  
  delegate :country_code, to: :country
  
end
