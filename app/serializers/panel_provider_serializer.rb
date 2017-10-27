class PanelProviderSerializer < ActiveModel::Serializer
  attributes :id, :code, :price_in_cents, :euro_price
end
