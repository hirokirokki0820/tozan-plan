class AddAddressesController < ApplicationController
  before_action :set_user, :set_companion

  def new
    AddressBook.create_address_book(@companion, @user) # address_book.rb に定義した privateメソッド
    redirect_to @companion.plan
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_companion
      @companion = Companion.find(params[:companion_id])
    end

end
