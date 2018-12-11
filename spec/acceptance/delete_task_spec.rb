# frozen_string_literal: true

require 'rails_helper'
feature 'Delete task' do
  given!(:day) { create(:day) }
  given!(:task) { create(:task, day: day) }

  scenario 'delete task', js: true do
    visit day_path(day)
    expect(page).to have_content task.list
    find('.glyphicon-trash').click
    expect(page).not_to have_content task.list
  end
end
