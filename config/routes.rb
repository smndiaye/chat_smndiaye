# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  get :aws_saa_exam_cheat_sheet, action: :index, controller: :blog

  # APIs
  mount Chat::Base, at: '/'
end
