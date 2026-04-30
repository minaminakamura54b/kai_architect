class SitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  def index
    @sites = Site.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to @site, notice: "現場を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @site.update(site_params)
      redirect_to @site, notice: "現場情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @site.destroy
    redirect_to sites_path, notice: "現場を削除しました"
  end

  private

  def set_site
    @site = Site.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:name, :address, :status, :description)
  end
end
