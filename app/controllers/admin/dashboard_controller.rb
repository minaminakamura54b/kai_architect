module Admin
  class DashboardController < BaseController
    def index
      @sites_count         = Site.count
      @users_count         = User.count
      @this_month_inspections_count    = Inspection.where(inspected_at: Time.current.beginning_of_month..).count
      @this_month_business_trips_count = BusinessTrip.where(created_at: Time.current.beginning_of_month..).count

      @pending_inspections = Inspection.includes(:site, :user)
                                       .where.not(status: :completed)
                                       .order(inspected_at: :desc)
                                       .limit(10)
      @recent_business_trips = BusinessTrip.includes(:site, :user)
                                           .order(started_at: :desc)
                                           .limit(10)
      @sites_with_progress = Site.includes(:inspections, :business_trips)
                                 .order(created_at: :desc)
    end
  end
end
