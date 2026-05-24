class InspectionMailer < ApplicationMailer
  def notification(inspection, recipient_emails)
    @inspection = inspection
    @site = inspection.site
    @user = inspection.user

    mail(
      to: Array(recipient_emails),
      subject: "【日報】#{@site.name} の日報が作成されました"
    )
  end
end
