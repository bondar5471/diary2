# frozen_string_literal: true

require 'rails_helper'

feature 'Create task on day', '
	click the add task button.
	open the form enter valid data,
	click the add task button
' do
  given(:day) { create(:day) }
  scenario 'click on create task on day', js: true do
    visit day_path(day)
    click_on 'Add task'
    fill_in 'task',	with: 'Mytext'
    fill_in 'date_begin', with: I18n.l(Date.today)
    fill_in 'date_end', with: I18n.l(Date.today)
    select 'day', from: 'task_duration'
    sleep 1
    click_on 'Add'
    within '#tasklist' do
      expect(page).to have_content 'Mytext'
    end
  end

  scenario 'hide Add task ', js: true do
    visit day_path(day)
    click_on 'Add task'
    sleep 1
    expect('#taskform').to_not have_content 'Add task'
  end

  scenario 'visible buton Add task after close form', js: true do
    visit day_path(day)
    click_on 'Add task'
    find('.glyphicon-remove.icoremove').click
    sleep 1
    expect(page).to have_content 'Add task'
  end

  scenario 'not create invalid task', js: true do
    visit day_path(day)
    click_on 'Add task'
    fill_in 'task',	with: ''
    fill_in 'date_begin', with: I18n.l(Date.today)
    fill_in 'date_end', with: I18n.l(Date.today)
    select 'day', from: 'task_duration'
    sleep 1
    click_on 'Add'
    within '#tasklist' do
      expect(page).to have_content ''
    end
  end
end
