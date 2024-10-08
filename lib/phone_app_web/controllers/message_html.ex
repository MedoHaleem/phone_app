defmodule PhoneAppWeb.MessageHTML do
  use PhoneAppWeb, :html

  alias PhoneApp.Conversations
  attr :changeset, Ecto.Changeset, required: true
  attr :contact, Conversations.Schema.Contact, required: false, default: nil

  def message_form(assigns)

  embed_templates "message_html/*"
end
