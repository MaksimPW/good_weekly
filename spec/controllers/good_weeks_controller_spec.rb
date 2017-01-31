require 'rails_helper'

RSpec.describe GoodWeeksController, type: :controller do
  let!(:user) { create(:user) }

  describe 'GET #current_week' do
    context 'auth' do
      let!(:good_week) { create(:good_week, monday: DateTime.now.beginning_of_week.to_date, user: user) }
      before { sign_in_helper user }

      it 'render template' do
        get :current_week
        expect(response).to render_template :show
      end

      it 'set current week' do
        get :current_week
        expect(assigns(:good_week).monday).to eq good_week.monday
      end
    end
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

    describe 'POST #create' do
      before { sign_in_helper user }

      it 'change record count in the database' do
        expect { post :create, params: { good_week: attributes_for(:good_week) } }.to change(GoodWeek, :count).by(1)
      end
    end

    describe 'PATCH #update' do
      let!(:good_week) { create(:good_week, monday: Date.new(2016, 1, 4), user: user) }
      before { sign_in_helper user }

      it 'assigns the requested good_week to @good_week' do
        patch :update, params: { id: good_week, good_week: attributes_for(:good_week) }
        expect(assigns(:good_week)).to eq good_week
      end

      it 'change week attrs' do
        patch :update, params: { id: good_week, good_week: { note: 'update' } }
        good_week.reload
        expect(good_week.note).to eq 'update'
      end
    end
  end
end