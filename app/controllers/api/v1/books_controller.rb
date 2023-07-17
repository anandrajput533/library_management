module Api
  module V1
    class BooksController < ApplicationController
      before_action :authorize_request
      before_action :book, only:[:show,:update,:destroy,:book_issued]
      skip_before_action :verify_authenticity_token

      def index
        @books = current_user.library.books
        render json: @books
      end

      def show
        render json: @book
      end

      def create
        @book = current_user.library.books.create(params_book)
        render json: @book
      end

      def update
        if @book.present?
          @book.update(params_book)
          render json: @book
        else
          render json: {message: "book is not found"}
        end
      end

      def destroy
        if @book.present?
          @book.destroy
          render json: {message: "Book deleted successfully "}
        else
          render json: {message: "Book is not found"}
        end
      end

      def search_book
        @books = Book.where("book_name Like ?", "%#{params[:name]}%")
        if @books.present?
          render json: @books
        else
          render json: {message: "book is not found"}
        end
      end

      def book_issued
        if @book.book_issued_date_end.strftime("%Y-%m-%d")< params[:book_issued_date_start]
        @book.update(book_issued_date_start: params[:book_issued_date_start], book_issued_date_end: params[:book_issued_date_end],book_issued_to: current_user.id)
        render json: {message: "book issued for #{@book.book_issued_date_start.strftime("%d-%m-%Y")} to #{@book.book_issued_date_end.strftime("%d-%m-%Y")}"}
        else
          render json: {message: "book is not available"} 
        end
      end


      private

      def params_book
        params.require(:book).permit(:book_name, :book_author, :book_description, :book_issued_to, :book_issued_date_start, :book_issued_date_end, :library_id, :book_category)
      end

      def book
        @book = Book.find_by(id:params[:id])
      end
    end
  end
end
