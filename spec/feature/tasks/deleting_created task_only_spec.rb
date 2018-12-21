# frozen_string_literal: true

require 'rails_helper'

feature 'Delete task just creating' do
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

  scenario 'click on create task on day and remove immediately', js: true do
    fill_in 'task',	with: 'MyTask'
    fill_in 'date_end', with: Time.zone.today
    select 'day', from: 'task_duration'
    click_on 'Add'
    find('.glyphicon-trash').click
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content 'MyTask'
  end
end
