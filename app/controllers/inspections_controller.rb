class InspectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_site, except: [:all, :select_site]
  before_action :set_inspection, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:new, :edit, :create]

  def all
    @inspections = Inspection.includes(:site, :user).order(inspected_at: :desc)
                              .paginate(page: params[:page], per_page: 15)
  end

  def select_site
    @sites = Site.order(:name)
  end

  def index
    @inspections = @site.inspections.includes(:user).order(inspected_at: :desc)
                        .paginate(page: params[:page], per_page: 15)
  end

  def new
    @inspection = @site.inspections.build
  end

  def create
    @inspection = @site.inspections.build(inspection_params)
    @inspection.user = current_user
    if @inspection.save
      notify_emails = Array(params[:inspection][:notify_emails]).reject(&:blank?)
      if notify_emails.any?
        begin
          InspectionMailer.notification(@inspection, notify_emails).deliver_now
          redirect_to site_inspection_path(@site, @inspection), notice: "点検記録を作成しました（#{notify_emails.join(", ")} に通知を送信しました）"
        rescue => e
          Rails.logger.error "メール送信失敗: #{e.message}"
          redirect_to site_inspection_path(@site, @inspection), alert: "点検記録は保存しましたが、メール送信に失敗しました。"
        end
      else
        redirect_to site_inspection_path(@site, @inspection), notice: "点検記録を作成しました"
      end
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

  def set_users
    @users = User.order(:name)
  end

  def inspection_params
    params.require(:inspection).permit(:inspected_at, :status, :result, :remarks)
  end
end
