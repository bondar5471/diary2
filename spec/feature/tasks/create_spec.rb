# frozen_string_literal: true

require 'rails_helper'

feature 'Create task on day', '
	click the add task button.
	open the form enter valid data,
	click add task button
' do
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

  scenario 'click on create task on day', js: true do
    fill_in 'task',	with: 'Mytext'
    fill_in 'date_end', with: Time.zone.today
    select 'day', from: 'task_duration'
    click_on 'Add'
    within '#tasklist' do
      expect(page).to have_content 'Mytext'
    end
  end

  scenario 'hide Add task ', js: true do
    expect('#taskform').to_not have_content 'Add task'
  end

  scenario 'visible buton Add task after close form', js: true do
    find('.glyphicon-remove.icoremove').click
    expect(page).to have_content 'Add task'
  end

  scenario 'not create invalid task', js: true do
    fill_in 'task',	with: ''
    fill_in 'date_end', with: Time.zone.today
    select 'day', from: 'task_duration'
    click_on 'Add'
    expect(page).not_to have_content '#tasklist'
  end
end
