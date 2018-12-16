# frozen_string_literal: true

require 'rails_helper'
feature 'Delete task' do
  given!(:day) { create(:day) }
  given(:task) { create(:task, day: day) }
  given(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user_email',	with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    visit day_path(day)
  end

  scenario 'delete task', js: true do
    expect(page).to have_content task.list
    find('.glyphicon-trash').click
    expect(page).not_to have_content task.list
  end
end
