module ApplicationHelper

  def full_title(page_title = "")
    base_title = "Kai Architect"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def site_status_badge(status)
    case status.to_s
    when "active"    then "badge-site-active"
    when "completed" then "badge-site-completed"
    when "suspended" then "badge-site-suspended"
    else "badge-site-completed"
    end
  end

  def inspection_status_badge(status)
    case status.to_s
    when "passed"  then "badge-passed"
    when "failed"  then "badge-failed"
    when "pending" then "badge-pending"
    else "badge-pending"
    end
  end
end
