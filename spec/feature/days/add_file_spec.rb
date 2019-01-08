# frozen_string_literal: true

require 'rails_helper'

feature 'Add file on day', '
	click the add foto button.
	open the form enter,
	click attach button
' do
  given(:day) { create(:day) }
  given!(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user_email',	with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    visit day_path(day)
  end

  scenario 'click on add foto and check file', js: true do
    click_on 'Add foto'
    find('form input[type="file"]').set('/home/bondar/Изображения/photo_2018-07-26_18-46-16.jpg')
    click_on 'Attach'
    expect(page).to have_xpath("//img[contains(@src,'photo_2018-07-26_18-46-16.jpg')]")
  end
end
