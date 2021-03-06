class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash.now[:alert] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was updated."
    else
      flash.now[:alert] = "Error saving wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "#{@wiki.title} was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  def public
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @wiki.update_attribute(:private, false)
    @wiki.update_attribute(:user_ids, [])
    if @wiki.save
      flash[:notice] =  "Wiki is public."
    else
      flash.now[:alert] = "Error changing wiki to public."
    end
    redirect_to @wiki
  end

  def private
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @wiki.update_attribute(:private, true)
    if @wiki.save
      flash[:notice] =  "Wiki is private."
    else
      flash.now[:alert] = "Error changing wiki to private."
    end
    redirect_to @wiki
  end

  def my_wikis
    @wikis = WikiPolicy::Scope.new(current_user, Wiki).show_my_wikis
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, user_ids:[])
  end
end
