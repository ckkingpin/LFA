module ApplicationHelper
  def tutor_emails
    mails = ""
    User.where(role: 'tutor').each {|user| mails += "#{user.email},"}
    mails
  end

  def active_link(resource)
    if params[:controller].split('/').first == resource
      'active'
    end
  end
end
