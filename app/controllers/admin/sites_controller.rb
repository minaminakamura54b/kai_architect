module Admin
  class SitesController < BaseController
    before_action :set_site, only: [:show, :edit, :update, :destroy]

    def index
      @sites = Site.includes(:inspections, :business_trips).order(created_at: :desc)
    end

    def show
    end

    def new
      @site = Site.new
    end

    def create
      @site = Site.new(site_params)
      if @site.save
        redirect_to admin_site_path(@site), notice: "現場を登録しました"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @site.update(site_params)
        redirect_to admin_site_path(@site), notice: "現場情報を更新しました"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @site.destroy
      redirect_to admin_sites_path, notice: "現場を削除しました"
    end

    private

    def set_site
      @site = Site.find(params[:id])
    end

    def site_params
      params.require(:site).permit(:name, :address, :status, :description)
    end
  end
end
