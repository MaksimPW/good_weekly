require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  let!(:user) { create(:user) }

  describe 'GET #index' do
    let!(:user_persons) { create_list(:person, 3, user: user) }
    let!(:other_persons) { create_list(:person, 10) }

    before do
      sign_in_helper user
      get :index
    end

    it 'render template' do
      expect(response).to render_template :index
    end

    it 'status response 200' do
      expect(response.status).to eq 200
    end

    it 'should get user persons' do
      expect(assigns(:persons)).to match_array(user_persons)
    end

    it 'not should get other persons' do
      expect(assigns(:persons)).to_not match_array(other_persons)
    end
  end

  describe 'GET #show' do
    let!(:person) { create(:person, user: user) }
    before { sign_in_helper user }

    it 'render template' do
      get :show, params: { id: person.id }
      expect(response).to render_template :show
    end

    it 'status response 200' do
      get :show, params: { id: person.id }
      expect(response.status).to eq 200
    end

    it 'should get person' do
      get :show, params: { id: person.id }
      expect(assigns(:person)).to eq person
    end
  end

  describe 'GET #new' do
    before { sign_in_helper user }

    it 'render template' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns a new person to @person' do
      get :new
      expect(assigns(:person)).to be_a_new(Person)
    end
  end

  describe 'POST #create' do
    before { sign_in_helper user }

    it 'change record count in the database' do
      expect { get :create, params: { person: attributes_for(:person) } }.to change(Person, :count).by(1)
    end
  end

  describe 'GET #edit' do
    let!(:person) { create(:person, user: user) }
    before { sign_in_helper user }

    it 'render template' do
      get :edit, params: { id: person.id }
      expect(response).to render_template :edit
    end

    it 'status response 200' do
      get :edit, params: { id: person.id }
      expect(response.status).to eq 200
    end

    it 'should get person' do
      get :edit, params: { id: person.id }
      expect(assigns(:person)).to eq person
    end
  end

  describe 'PATCH #update' do
    let!(:person) { create(:person, user: user) }
    before { sign_in_helper user }

    it 'assigns the requested person to @person' do
      patch :update, params: { id: person, person: attributes_for(:person) }
      expect(assigns(:person)).to eq person
    end

    it 'change person attrs' do
      updated = Hash.new
      updated[:fio] = 'Валерий Петрович'
      updated[:birthday] = Date.new
      updated[:description] = 'Прилетело НЛО и забрало эту запись'
      updated[:note] = 'Хороший человек'

      patch :update, params: { id: person, person: updated }
      person.reload

      %w'name description author comment rating'.each do |value|
        expect(person[value]).to eq updated[value.to_sym]
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:person) { create(:person, user: user) }
    before { sign_in_helper user }

    it 'change record count in the database' do
      expect { delete :destroy, params: { id: person } }.to change(Person, :count).by(-1)
    end
  end
end