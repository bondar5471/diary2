# frozen_string_literal: true

require 'rails_helper'
feature 'accordion task panel' do
  given(:day) { create(:day) }
  given!(:user) { create(:user) }
  given!(:task) { create(:task) }
  before do
    visit new_user_session_path
    fill_in 'user_email',	with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    visit day_path(day)
    click_on 'Task on day'
  end
  scenario 'Accordion Panel Display', js: true do
    expect(page).to have_css '.panel'
    within '.onetask' do
      expect(page).to have_content 'Mytext'
    end
  end
end
