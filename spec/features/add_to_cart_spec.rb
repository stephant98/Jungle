require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do 
   # SETUP
   before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see cart change to 1" do
    # ACT
    visit root_path

    # DEBUG
    save_screenshot

    expect(page).to have_text('My Cart (0)')

    click_on('Add', match: :first)

    # VERIFY
    expect(page).to have_text('My Cart (1)')

    save_screenshot
  end
end
