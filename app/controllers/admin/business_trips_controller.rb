module Admin
  class BusinessTripsController < BaseController
    before_action :set_business_trip, only: [:show, :destroy]

    def index
      @business_trips = BusinessTrip.includes(:site, :user)
                                    .order(started_at: :desc)
                                    .paginate(page: params[:page], per_page: 20)
    end

    def show
    end

    def destroy
      @business_trip.destroy
      redirect_to admin_business_trips_path, notice: "出張報告を削除しました"
    end

    private

    def set_business_trip
      @business_trip = BusinessTrip.includes(:site, :user).find(params[:id])
    end
  end
end
