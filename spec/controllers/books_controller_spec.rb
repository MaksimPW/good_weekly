require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let!(:user) { create(:user) }

  describe 'GET #index' do
    let!(:user_books) { create_list(:book, 3, user: user) }
    let!(:other_books) { create_list(:book, 10) }

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

    it 'should get user books' do
      expect(assigns(:books)).to match_array(user_books)
    end

    it 'not should get other books' do
      expect(assigns(:books)).to_not match_array(other_books)
    end
  end

  describe 'GET #show' do
    let!(:book) { create(:book, user: user) }
    before { sign_in_helper user }

    it 'render template' do
      get :show, params: { id: book.id }
      expect(response).to render_template :show
    end

    it 'status response 200' do
      get :show, params: { id: book.id }
      expect(response.status).to eq 200
    end

    it 'should get book' do
      get :show, params: { id: book.id }
      expect(assigns(:book)).to eq book
    end
  end

  describe 'GET #new' do
    before { sign_in_helper user }

    it 'render template' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns a new Book to @book' do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe 'POST #create' do
    before { sign_in_helper user }

    it 'change record count in the database' do
      expect { post :create, params: { book: attributes_for(:book) } }.to change(Book, :count).by(1)
    end
  end

  describe 'GET #edit' do
    let!(:book) { create(:book, user: user) }
    before { sign_in_helper user }

    it 'render template' do
      get :edit, params: { id: book.id }
      expect(response).to render_template :edit
    end

    it 'status response 200' do
      get :edit, params: { id: book.id }
      expect(response.status).to eq 200
    end

    it 'should get book' do
      get :edit, params: { id: book.id }
      expect(assigns(:book)).to eq book
    end
  end

  describe 'PATCH #update' do
    let!(:book) { create(:book, user: user) }
    before { sign_in_helper user }

    it 'assigns the requested book to @book' do
      patch :update, params: { id: book, book: attributes_for(:book) }
      expect(assigns(:book)).to eq book
    end

    it 'change book attrs' do
      updated = Hash.new
      updated[:name] = 'Просто книжка'
      updated[:description] = 'Обычное описание'
      updated[:author] = 'Прилетело НЛО и забрало эту запись'
      updated[:comment] = 'Хороший комментарий для хорошей книги'
      updated[:rating] = 10

      patch :update, params: { id: book, book: updated }
      book.reload

      %w'name description author comment rating'.each do |value|
        expect(book[value]).to eq updated[value.to_sym]
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:book) { create(:book, user: user) }
    before { sign_in_helper user }

    it 'change record count in the database' do
      expect { delete :destroy, params: { id: book } }.to change(Book, :count).by(-1)
    end
  end
end