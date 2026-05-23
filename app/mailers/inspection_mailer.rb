class InspectionMailer < ApplicationMailer
  def notification(inspection, recipient_emails)
    @inspection = inspection
    @site = inspection.site
    @user = inspection.user

    mail(
      to: Array(recipient_emails),
      subject: "【点検記録】#{@site.name} の点検が記録されました"
    )
  end
end
