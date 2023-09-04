defmodule FunEvents.WhatsappHandler do




  def build_and_send(guest) do
    with {:ok, _} <- validate_country(guest) ,
    {:ok, _} <- validate_phone(guest) do
      message = FunEvents.Parameters.get_parameter_by_type("message", "#{guest.event_id}", "event")
      message.value["text"]
      |> String.replace("${invitation_link}", guest.invite_url_short)
      |> send_whatsapp(guest)
      |> handle_response()
    end

  end

  defp send_whatsapp(content, guest) do
    url = FunEvents.Parameters.get_parameter_by_type("whastapp_url", "#{guest.event_id}", "event")
    data = %{
      chatId: build_number(guest),
      contentType: "string",
      content: content
    }
    HTTPoison.post(url.value["url"], Jason.encode!(data), ["Content-Type": "application/json", "x-api-key": "your_global_api_key_here"])
  end

  defp build_number(guest) do
    country = Countries.get(guest.country)
    case guest.country  do
      "MX" -> "#{country.country_code}1#{guest.phone}@c.us"
      "US" -> "#{country.country_code}#{guest.phone}@c.us"
    end

  end
  defp validate_country(guest) do
    if !is_nil(guest.country) do
      {:ok, :valid}
    else
      {:error, "no tiene configurado un pais"}
    end
  end

  defp validate_phone( guest) do
    if !is_nil(guest.phone) do
      {:ok, :valid}
    else
      {:error, "no tiene configurado numero de telefono"}
    end
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: status_code} = response} when status_code in 200..299 ->
        {:ok, Jason.decode!(response.body)}

      {:ok, %HTTPoison.Response{status_code: status_code} = response} when status_code in 400..599 ->
        {:error, Jason.decode!(response.body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{reason: reason}}

      {:error, _error} ->
        {:error, "Api client error"}
    end
  end
end
