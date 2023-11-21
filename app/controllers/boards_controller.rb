class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    redirect_to = Board.create(board_params)
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    board = Board.find(params[:id])
    board.update(board_params)

    redirect_to board # /boards/:idへリダイレクトされる
  end

  def destroy
    Board.find(params[:id]).delete

    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:author_name, :title, :body)
  end

end
