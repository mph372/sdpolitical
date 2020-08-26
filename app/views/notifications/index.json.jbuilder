json.array! @notifications do |notification|
    json.id notification.id
    json.unread !notification.read_at?
    json.template render partial: "notifications/expenditures/expenditures", locals: {notification: notification}, formats: [:html]
end