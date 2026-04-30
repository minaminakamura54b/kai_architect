class InspectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_site, except: [:all, :select_site]
  before_action :set_inspection, only: [:show, :edit, :update, :destroy]

  def all
    @inspections = Inspection.includes(:site, :user).order(inspected_at: :desc)
  end

  def select_site
    @sites = Site.order(:name)
  end

  def index
    @inspections = @site.inspections.order(inspected_at: :desc)
  end

  def new
    @inspection = @site.inspections.build
  end

  def create
    @inspection = @site.inspections.build(inspection_params)
    @inspection.user = current_user
    if @inspection.save
      notify_email = params[:inspection][:notify_email].presence
      InspectionMailer.notification(@inspection, notify_email).deliver_later if notify_email
      redirect_to site_inspection_path(@site, @inspection), notice: "点検記録を作成しました#{notify_email ? "（#{notify_email} に通知を送信しました）" : ""}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @inspection.update(inspection_params)
      redirect_to site_inspection_path(@site, @inspection), notice: "点検記録を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @inspection.destroy
    redirect_to site_inspections_path(@site), notice: "点検記録を削除しました"
  end

  private

  def set_site
    @site = Site.find(params[:site_id])
  end

  def set_inspection
    @inspection = @site.inspections.find(params[:id])
  end

  def inspection_params
    params.require(:inspection).permit(:inspected_at, :status, :result, :remarks)
  end
end
