section "Creating Tags Categories" do
  ActsAsTaggableOn::Tag.category.create!(name: 'Rateče - Planica')
  ActsAsTaggableOn::Tag.category.create!(name: 'Podkoren')
  ActsAsTaggableOn::Tag.category.create!(name: 'Kranjska Gora')
  ActsAsTaggableOn::Tag.category.create!(name: '"Rute" - Gozd Martuljek in Srednji Vrh')
  ActsAsTaggableOn::Tag.category.create!(name: 'Dovje - Mojstrana')
end
