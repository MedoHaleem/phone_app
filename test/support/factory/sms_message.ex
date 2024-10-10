defmodule Test.Factory.SmsMessageFactory do
  def params(overrides \\ %{}) do
    %{
      to: "+19998887777",
      from: "+11112223333",
      direction: :outgoing,
      message_sid: Ecto.UUID.generate(),
      account_sid: "account_sid",
      body: "body",
      status: "queued"
    }
    |> Map.merge(overrides)
  end

  def create(overrides \\ %{}) do
    {:ok, message} = overrides |> params() |> PhoneApp.Conversations.create_sms_message()
    message
  end
end
