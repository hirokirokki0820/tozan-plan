class AddressBooksController < ApplicationController
  before_action :set_address_book, only: [ :edit, :update, :destroy]
  before_action :set_user
  before_action :require_user

  def index
    @address_books = @user.address_books
  end

  def new
    @address_book = AddressBook.new
  end

  def edit
  end

  def create
    @address_book = AddressBook.new(address_book_params)
    @address_book.user = @user
    if @address_book.save
      flash[:notice] = "アドレス情報が追加されました"
      redirect_to user_address_books_path(@user)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @address_book.update(address_book_params)
      flash[:notice] = "アドレス情報が更新されました"
      redirect_to user_address_books_path(@user)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @address_book.destroy
    redirect_to user_address_books_path(@user), notice: "アドレス情報が1件削除されました", status: :see_other
  end


  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_address_book
      @address_book = AddressBook.find(params[:id])
    end

    def address_book_params
      params.require(:address_book).permit(:full_name, :gender, :birthday, :age, :address, :phone_number, :emergency_contact, :emergency_number)
    end

    def require_same_user
      if current_user != @address_book.user
        flash[:alert] = "ユーザーご本人以外のアクセスは禁止されています"
        redirect_to current_user
      end
    end
end
