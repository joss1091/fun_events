defmodule FunEvents.WhatsappHandler do



  def build_and_send(guests) when is_list(guests) do
    guests
    |> filter_disabled_send_message()
    |> remove_invalid_guests()
    |> Enum.map(&build_and_send/1)

  end

  def build_and_send(guest) do
    with {:ok, _} <- validate_country(guest) ,
    {:ok, _} <- validate_phone(guest) do
      message = FunEvents.Parameters.get_parameter_by_type("message", "#{guest.event_id}", "event")
      with {:ok, res} <- send_message(guest,message) ,
      {:ok, _ } <- send_custom_message(guest) do

        {:ok, res}
      end
    end

  end

  defp remove_invalid_guests(guests) do
    guests
    |> Enum.reject(&(is_nil(&1.guest.invite_url_short)))
    |> Enum.reject(&(is_nil(&1.guest.adult_max )))
    |> Enum.reject(&(is_nil(&1.guest.phone )))
    |> Enum.filter(&(is_nil(&1.guest.last_notification_date )))
    |> Enum.filter(&(is_nil(&1.guest.date_response )))
  end

  defp send_message(guest, message) do
    message.value["text"]
    |> String.replace("${family_name}", "#{guest.name} #{guest.last_name}" |> String.upcase())
    |> String.replace("${invitation_link}", guest.invite_url_short)
    |> String.replace("${adult_quantity}", "#{guest.adult_max}")
    |> send_whatsapp(guest)
    |> handle_response()
  end

  defp send_custom_message(guest) do
    if guest.send_custom_message do

      message = FunEvents.Parameters.get_parameter_by_type("custom_message", "#{guest.event_id}", "event")
      message.value["text"]
      |> send_whatsapp(guest)
      |> handle_response()
    else
      {:ok, guest}
    end
  end

  defp filter_disabled_send_message(guests) do
    guests
    |> Enum.filter(&(&1.send_notification))
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
