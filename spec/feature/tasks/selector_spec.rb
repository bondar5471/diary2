# frozen_string_literal: true

require 'rails_helper'

feature 'Check for correct display of selectors' do
  given(:day) { create(:day) }
  given!(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user_email',	with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    visit day_path(day)
    click_on 'Add task'
  end

  scenario 'click on create task check selector month', js: true do
    select 'month', from: 'task_duration'
    within '#taskform' do
      expect(page).to have_css '#task_year'
      expect(page).to have_css '#date_month'
    end
  end
  scenario 'click on create task check selector year', js: true do
    select 'year', from: 'task_duration'
    within '#taskform' do
      expect(page).to have_css '#task_year'
    end
  end
  scenario 'click on create task check selector week', js: true do
    select 'week', from: 'task_duration'
    within '#taskform' do
      expect(page).to have_css '#task_week'
    end
  end
end
