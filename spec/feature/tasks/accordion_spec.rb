# frozen_string_literal: true

require 'rails_helper'
feature 'accordion task panel' do
  given(:day) { create(:day) }
  given!(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user_email',	with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    visit day_path(day)
    click_on 'Add task'
    fill_in 'task',	with: 'MyTask'
    fill_in 'date_end', with: Time.zone.today
    select 'day', from: 'task_duration'
    click_on 'Add'
  end
  scenario 'Accordion Panel Display', js: true do
    expect(page).to have_css '.panel'
    within '.onetask' do
      expect(page).to have_content 'MyTask'
    end
  end
end
