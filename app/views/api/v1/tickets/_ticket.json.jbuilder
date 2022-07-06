json.extract! ticket, :id, :incident_creation_date,:date_incident,:date_ticket_resolution, :title, :description, :priority, :status,:tags, :ticket_deadline, :created_at, :updated_at
json.url api_v1_ticket_url(ticket, format: :json)
