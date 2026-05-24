module Admin
  class InspectionsController < BaseController
    before_action :set_inspection, only: [:show, :destroy]

    def index
      @inspections = Inspection.includes(:site, :user)
                               .order(inspected_at: :desc)
                               .paginate(page: params[:page], per_page: 20)
    end

    def show
    end

    def destroy
      @inspection.destroy
      redirect_to admin_inspections_path, notice: "日報を削除しました"
    end

    private

    def set_inspection
      @inspection = Inspection.includes(:site, :user).find(params[:id])
    end
  end
end
