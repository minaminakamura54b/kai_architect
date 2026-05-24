class BusinessTripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_site, except: [:all, :select_site]
  before_action :set_business_trip, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:new, :edit, :create]

  def all
    @business_trips = BusinessTrip.includes(:site, :user).order(started_at: :desc)
                                  .paginate(page: params[:page], per_page: 15)
  end

  def select_site
    @sites = Site.order(:name)
  end

  def index
    @business_trips = @site.business_trips.includes(:user).order(started_at: :desc)
                            .paginate(page: params[:page], per_page: 15)
  end

  def show
  end

  def new
    @business_trip = @site.business_trips.build
  end

  def create
    @business_trip = @site.business_trips.build(business_trip_params)
    @business_trip.user = current_user
    if @business_trip.save
      notify_emails = Array(params[:business_trip][:notify_emails]).reject(&:blank?)
      if notify_emails.any?
        begin
          BusinessTripMailer.notification(@business_trip, notify_emails).deliver_now
          redirect_to site_business_trip_path(@site, @business_trip), notice: "出張報告を作成しました（#{notify_emails.join(", ")} に通知を送信しました）"
        rescue => e
          Rails.logger.error "メール送信失敗: #{e.message}"
          redirect_to site_business_trip_path(@site, @business_trip), alert: "出張報告は保存しましたが、メール送信に失敗しました。"
        end
      else
        redirect_to site_business_trip_path(@site, @business_trip), notice: "出張報告を作成しました"
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @business_trip.update(business_trip_params)
      redirect_to site_business_trip_path(@site, @business_trip), notice: "出張報告を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @business_trip.destroy
    redirect_to site_business_trips_path(@site), notice: "出張報告を削除しました"
  end

  private

  def set_site
    @site = Site.find(params[:site_id])
  end

  def set_business_trip
    @business_trip = @site.business_trips.find(params[:id])
  end

  def set_users
    @users = User.order(:name)
  end

  def business_trip_params
    params.require(:business_trip).permit(:started_at, :ended_at, :destination, :purpose, :report, :expenses)
  end
end
