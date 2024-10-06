defmodule PhoneAppWeb.MessageController do
  use PhoneAppWeb, :controller

  plug :load_conversation_list

  def index(conn, _params) do
    case conn.assigns.conversation_list do
      [%{contact: contact} | _] ->
        path = ~p(/messages/#{contact.id})
        redirect(conn, to: path)

      [] ->
        redirect(conn, to: ~p(/messages/new))
    end
  end

  def show(conn, params = %{"contact_id" => contact_id}) do
    contact = PhoneApp.Conversations.get_contact!(contact_id)
    conversation = PhoneApp.Conversations.load_conversation_with(contact)

    conn
    |> assign(:conversation, conversation)
    |> assign(:changeset, changeset(params))
    |> render("show.html")
  end

  defp changeset(params) do
    conversation_params = Map.get(params, "message", %{})
    PhoneApp.Conversations.new_message_changeset(conversation_params)
  end

  defp load_conversation_list(conn, _params) do
    conversations = PhoneApp.Conversations.load_conversation_list()
    assign(conn, :conversation_list, conversations)
  end
end
