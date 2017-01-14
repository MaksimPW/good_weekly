require 'rails_helper'

RSpec.describe GoodWeeksController, type: :controller do
  let!(:user) { create(:user) }

  describe 'GET #current_week' do

  end

  describe 'GET #show' do
    context 'auth' do
      let!(:good_week) { create(:good_week, monday: Date.new(2016, 1, 4), user: user) }
      before { sign_in_helper user }

      it 'render template' do
        get :show, params: { year: 2016, week: 1 }
        expect(response).to render_template :show
      end

      it 'assigns the requested good_week to @good_week' do
        get :show, params: { year: 2016, week: 1 }
        expect(assigns(:good_week)).to eq good_week
      end

      it 'assigns the empty week to new @good_week' do
        get :show, params: { year: 1970, week: 1 }
        new_week = GoodWeek.new(user: user, monday: Date.new(1969, 12, 29))
        expect(assigns(:good_week).monday).to eq new_week.monday
      end
    end
  end
end