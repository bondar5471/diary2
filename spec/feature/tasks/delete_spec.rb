# frozen_string_literal: true

require 'rails_helper'
feature 'Delete task' do
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
    find('.glyphicon-trash').click
  end

  scenario 'delete task', js: true do
    page.driver.browser.switch_to.alert.accept
    within '.task-container' do
      expect(page).not_to have_css '.onetask'
    end
  end
  scenario 'note delete task if allert JS cancel', js: true do
    page.driver.browser.switch_to.alert.dismiss
    within '.task-container' do
      expect(page).to have_css '.onetask'
    end
  end
end
