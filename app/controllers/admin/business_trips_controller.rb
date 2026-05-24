module Admin
  class BusinessTripsController < BaseController
    def index
      @business_trips = BusinessTrip.includes(:site, :user)
                                    .order(started_at: :desc)
                                    .paginate(page: params[:page], per_page: 20)
    end

    def show
      @business_trip = BusinessTrip.includes(:site, :user).find(params[:id])
    end
  end
end
