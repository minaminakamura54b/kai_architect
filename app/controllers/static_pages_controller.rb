class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @sites_count = Site.count
    @active_sites_count = Site.where(status: :active).count
    @inspections_count = Inspection.count
    @failed_inspections_count = Inspection.where(status: :failed).count
    @business_trips_count = BusinessTrip.count
    @recent_inspections = Inspection.order(inspected_at: :desc).limit(5)
    @recent_business_trips = BusinessTrip.order(started_at: :desc).limit(5)
  end
end
