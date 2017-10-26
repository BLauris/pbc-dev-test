ISO_CODES   = [ "LV", "GB", "US" ]
LV_CITIES   = ["Kuldīga", "Rīga", "Ventspils", "Liepāja", "Jelpgava"]
GB_CITIES   = ["London", "Birmingham", "Bristol", "Chester", "Derby"]
US_CITIES   = ["Los Angeles", "Austin", "Boston", "Sacramento", "Saint Paul"]
FIVE_RANDOM = ["Berin", "Paris", "Porto", "Milan", "Madrid"]

ALL_CITIES = (LV_CITIES + GB_CITIES + US_CITIES + FIVE_RANDOM)

puts "----> START"

User.destroy_all
PanelProvider.destroy_all
Country.destroy_all
Location.destroy_all
LocationGroup.destroy_all
TargetGroup.destroy_all

puts "----> Users "

User.create(email: "bligzna.lauris@gmail.com")

puts "----> PanelProviders and Countrues "

arrays_to_cents = ArrayElementsToCents.new
country_code = (ISO_CODES - Country.pluck(:country_code)).last
panel_provider = PanelProvider.create(code: Faker::Code.ean, price_in_cents: arrays_to_cents.count!)
Country.create(country_code: country_code, panel_provider_id: panel_provider.id)

html_to_cents = HtmlNodesToCents.new
country_code = (ISO_CODES - Country.pluck(:country_code)).last
panel_provider = PanelProvider.create(code: Faker::Code.ean, price_in_cents: html_to_cents.count!)
Country.create(country_code: country_code, panel_provider_id: panel_provider.id)

letters_to_cents = LettersToCents.new
country_code = (ISO_CODES - Country.pluck(:country_code)).last
panel_provider = PanelProvider.create(code: Faker::Code.ean, price_in_cents: letters_to_cents.count!)
Country.create(country_code: country_code, panel_provider_id: panel_provider.id)

puts "----> Locations "

ALL_CITIES.each do |city|
  Location.create(
    name: city,
    secret_code: Faker::Code.isbn
  )
end

puts "----> Location Groups "

ISO_CODES.each do |iso|
  country = Country.find_by(country_code: iso)
  
  LocationGroup.create(
    name: Faker::Name.title,
    country_id: country.id,
    panel_provider_id: country.panel_provider.id
  )
end

LocationGroup.create(name: Faker::Name.title)

puts "----> Target Groups "

def level_one_children(parent_id)
  3.times do
    tg = TargetGroup.create(name: Faker::Name.title, parent_id: parent_id)
    level_two_children(tg.id)
  end
end

def level_two_children(parent_id)
  3.times do
    tg = TargetGroup.create(name: Faker::Name.title, parent_id: parent_id)
    level_three_children(tg.id)
  end
end

def level_three_children(parent_id)
  3.times do
    TargetGroup.create(name: Faker::Name.title, parent_id: parent_id)
  end
end

ISO_CODES.each do |iso|
  panel_provider = PanelProvider.joins(:countries).where(countries: {country_code: iso}).last
  
  tg = TargetGroup.create(
    name: Faker::Name.title,
    panel_provider_id: panel_provider.id
  )
  
  level_one_children(tg.id)
end

puts "----> DONE "