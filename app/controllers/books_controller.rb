class BooksController < ApplicationController
    before_action :authenticate_user!, except: [:top, :new]
    before_action :correct_user, only: [:edit, :update]

    def new
    end
    def top
    end
    def index#画像一覧画面 #自己紹介画面
    	 @books = Book.all
    	 @book = Book.new
    end

    def show
        @book = Book.find(params[:id])
    end

    def create  #投稿画像保存#form_forの情報がやってくるアクション
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
            flash[:notice] = "successfully"
    		redirect_to book_path(@book)
		else
            @books = Book.all
            render :index
        end
	end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
        flash[:notice] = "successfully"
        redirect_to book_path(@book)
        else
        render :edit
        end
    end

    private

    def book_params
        params.require(:book).permit(:title, :image, :body)
    end

    def correct_user #ログインしたユーザーと違ったら別のリンクに飛ぶ
        @book = Book.find(params[:id])
        if current_user != @book.user
            redirect_to books_path
        end
    end
end