module Admin
  class InspectionsController < BaseController
    def index
      @inspections = Inspection.includes(:site, :user)
                               .order(inspected_at: :desc)
                               .paginate(page: params[:page], per_page: 20)
    end

    def show
      @inspection = Inspection.includes(:site, :user).find(params[:id])
    end
  end
end
