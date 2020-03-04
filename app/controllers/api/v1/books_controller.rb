class Api::V1::BooksController < ApplicationController
  def index
    render :json => { "name": "febin" }
  end

  def show
    book = Book.find_by(id: params[:id])
    if book.present?
      render json: {status: 'SUCCESS', message: 'Fetched book', data: book}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Book not found'}, status: :unprocessable_entity
    end
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: {status: 'SUCCESS', message: 'Book created successfully', data: book}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Blog not created', data: book.errors}, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.permit(:name)
  end
end
